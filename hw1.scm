

(define <boolean>
    (new (*parser (char #\#))
	 (*parser (char #\t))
	 (*parser (char #\f))
	 (*disj 2)
	 (*caten 2)
	 done))

(define <CharPrefix>
  (new (*parser (char #\#))
	(*parser (char #\\))
	(*caten 2)
	done))
	
(define <VisibleSimpleChar>
  (new (*parser (range #\! #\~))
	(*pack (lambda(ch) (list->string `(,ch))))
	done))
	
(define <NamedChar> ;missing page & return 
   (new (*parser (range (integer->char 955) (integer->char 955))) ;lambda
	(*parser (range (integer->char 0) (integer->char 0))) ;nul
	(*parser (range (integer->char 10) (integer->char 10))) ;newline
	(*parser (range (integer->char 31) (integer->char 31))) ;space
	(*parser (range (integer->char 9) (integer->char 9))) ;tab
	(*disj 5)
	done))

(define <HexChar>

    (new (*parser (range #\0 #\9))
	 (*parser (range #\a #\f))
	 (*parser (range #\A #\F))
	 (*disj 3)
	 done))

(define <HexUnicodeChar>
    (new (*parser <HexChar>)
    (*parser <HexChar>) *star 
    (*caten 2)
    done))
    
(define <Natural>
    (new (*parser (range #\0 #\9))
	 (*parser (range #\0 #\9)) *star
	 (*caten 2)
	 done))

(define <Integer>
    (new (*parser (char #\+))
       (*parser <Natural>)
       (*caten 2)

       (*parser (char #\-))
       (*parser <Natural>)
       (*caten 2)

       (*parser <Natural>)

       (*disj 3)

       done))
        
  
(define <Fraction>
    (new (*parser <Integer>)
	(*parser (char #\/))
	(*parser <Natural>)
	(*caten 3)
	done))
	
(define <Number>
    (new 
	  (*parser <Fraction>)
	  (*parser <Integer>)
	  (*disj 2)
	  done))
	  
(define <StringVisibleChar>
    (new (*parser (range (integer->char 31) #\~))
	(*pack (lambda(ch) (list->string `(,ch))))
	done))
    
(define <StringMetaChar>
    (new (*parser (char #\\))
         (*parser (char #\\))
         (*parser (char #\"))
         (*parser (char #\t))
         (*parser (char #\n))
         (*parser (char #\r))
         (*disj 5)
         (*caten 2)
         done))
         
(define <StringHexChar>
    (new (*parser (char #\\))
         (*parser <HexChar>) *star
         (*caten 2)
         done))
         
(define <StringChar>
    (new (*parser <StringVisibleChar>)
         (*parser <StringMetaChar>)
         (*parser <StringHexChar>)
         (*disj 3)
         done))
         
(define <String>
    (new (*parser (char #\"))
         (*parser (range (integer->char 31) (integer->char 31))) ;space
         (*parser <StringChar>) *star
         (*parser (range (integer->char 31) (integer->char 31))) ;space
         (*parser (char #\"))
         (*disj 5)
         done))


  
(define <sexpr> 
  ...)
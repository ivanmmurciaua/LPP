;;
;; Solución práctica 2
;; 

#lang r6rs
(import (rnrs)
        (schemeunit))

;----------------------------
; Ejercicio 1: (maximo lista)
;----------------------------

;; Función mayor

(define (mayor n1 n2)
  (if (> n1 n2)
      n1
      n2))

;; Pruebas

(display "Probando 'mayor'\n")
(check-equal? (mayor 2 4) 4)
(check-equal? (mayor 4 2) 4)


;; Función maximo

(define (maximo lista)
  (if (null? (cdr lista))
      (car lista)
      (mayor (car lista) (maximo (cdr lista)))))

;; Pruebas

(display "Probando 'maximo'\n")

(check-equal? (maximo '(10 -1 20 3)) 20)
(check-equal? (maximo '(-10 -30 -18 -12)) -10)


;-------------------------------------
; Ejercicio 2: (pertenece? elem lista)
;              (repetidos? lista)
;-------------------------------------

;; a)

(define (pertenece? dato lista)
  (cond
    ((null? lista) #f)
    ((equal? dato (car lista)) #t)
    (else (pertenece? dato (cdr lista)))))

;; Pruebas
(display "Probando 'pertenece?'\n")
(check-true (pertenece? 'a '(b c d a f g)))
(check-false (pertenece? 1 '(2 3 4 5 6)))
(check-false (pertenece? (cons 1 2) (list (cons 2 3) (cons 3 4) (cons 9 0))))


;; b)

(define (repetidos? lista)
  (cond
    ((null? lista) #f)
    ((pertenece? (car lista) (cdr lista)) #t)
    (else (repetidos? (cdr lista)))))

;; Pruebas
(display "Probando 'repetidos?'\n")
(check-true (repetidos? '(1 2 3 5 4 5 6)))
(check-false (repetidos? '(adios hola que tal)))
(check-true (repetidos? '(#t #f #t #t #t)))

;---------------------------
; Ejercicio 3: Box & pointer
;---------------------------

;; a) Definición de p1, p2 y p3
(display "Definición de p1, p2 y p3.\n")
(define p1 (list (cons 1 2) 3))
(define p2 (list (list 'a 'b)))
(define p3 (cons 4 (cons p1 (cons p2 5))))

;; b) p1 y p2 son listas, de dos y un solo elemento respectivamente,
;;    mientras p3 es una pareja con otro par de parejas anidadas

;; c)
(display "Obteniendo 3 de p3\n")
(check-equal? (cadr (cadr p3)) 3)
(display "Obteniendo 5 de p3\n")
(check-equal? (cdddr p3) 5)

;; d) Definición de p4
(display "Definición de p4.\n")
(define p4 (list
            (cons (cons 1 2) (cons 3 4))
            (list 5 6 (cons 7 (cons 8 9)))
            10))


;--------------------------------------------
; Ejercicio 4: (binario-a-decimal lista-bits)
;--------------------------------------------

(define (binario-a-decimal lista-bits)
  (if (null? lista-bits)
      0
      (+ (* (car lista-bits) (expt 2 (length (cdr lista-bits))))
         (binario-a-decimal (cdr lista-bits)))))

;; Pruebas
(display "Probando 'binario-a-decimal'\n")
(check-equal? (binario-a-decimal '(1 1 1 1)) 15)
(check-equal? (binario-a-decimal '(0)) 0)
(check-equal? (binario-a-decimal '(1 1 0)) 6)
(check-equal? (binario-a-decimal '(1 1)) 3)

;----------------------------------------------
; Ejercicio 5: (ordenada-creciente? lista-nums)
;----------------------------------------------

;; Versión 1
(define (ordenada-creciente? lista)
  (cond
    ((null? (cdr lista)) #t)
    ((> (car lista) (cadr lista)) #f)
    (else (ordenada-creciente? (cdr lista)))))
      
;; Versión 2
(define (ordenada-creciente-v2? lista)
    (if (null? (cdr lista))
      #t
      (and (<= (car lista) (cadr lista))
           (ordenada-creciente-v2? (cdr lista)))))

(display "Probando 'ordenada-creciente?'\n")
(ordenada-creciente? '(-1 23 45 59 99))  ; ⇒ #t
(ordenada-creciente? '(12 50 -1 293 1000))  ; ⇒ #f
(ordenada-creciente? '(3))  ; ⇒ #t

(ordenada-creciente-v2? '(-1 23 45 59 99))  ; ⇒ #t
(ordenada-creciente-v2? '(12 50 -1 293 1000))  ; ⇒ #f
(ordenada-creciente-v2? '(3))  ; ⇒ #t


;----------------------------------------------
; Ejercicio 6: (inc-izq pareja)
;              (cuenta-impares-pares lista-num)
;----------------------------------------------

;; a)

(define (inc-izq pareja)
  (cons (+ 1 (car pareja))
        (cdr pareja)))

(define (inc-der pareja)
  (cons (car pareja)
        (+ 1 (cdr pareja))))

;; Pruebas
(display "Probando 'inc-izq' y 'inc-der'\n")
(check-equal? (inc-izq (cons 10 20)) (cons 11 20))
(check-equal? (inc-der (cons 10 20)) (cons 10 21))

;; b)

(define (cuenta-impares-pares lista)
  (cond
    ((null? lista) (cons 0 0))
    ((odd? (car lista)) (inc-izq (cuenta-impares-pares (cdr lista))))
    (else (inc-der (cuenta-impares-pares (cdr lista))))))

;; Pruebas
(display "Probando 'cuenta-impares-pares'\n")
(check-equal? (cuenta-impares-pares '(3 2 1 4 8 7 6 5)) (cons 4 4))
(check-equal? (cuenta-impares-pares '(3 1 5)) (cons 3 0))

;----------------------------------
; Ejercicio 7: (cadena-mayor lista)
;----------------------------------

; Devuelve una pareja con la cadena s y su longitud si s es mayor a la cadena de la pareja p,
; o en caso contrario devuelve la propia pareja p
(define (par-de-cadena-mayor s p)
  (if (> (string-length s) (string-length (car p)))
      (cons s (string-length s))
      p))

;; Pruebas par-de-cadena-mayor
(display "Probando 'par-de-cadena-mayor'\n")
(check-equal? (par-de-cadena-mayor "cinco" (cons "una" 3)) (cons "cinco" 5))
(check-equal? (par-de-cadena-mayor "personaje" (cons "luna" 4)) (cons "personaje" 9)) 

(define (cadena-mayor lista)
  (if (null? lista)
      (cons "" 0)
      (par-de-cadena-mayor (car lista) (cadena-mayor (cdr lista)))))

;; Pruebas
(display "Probando 'cadena-mayor'\n")
(check-equal? (cadena-mayor '("vamos" "a" "obtener" "la" "cadena" "mayor")) (cons "obtener" 7)) 
(check-equal? (cadena-mayor '("prueba" "con" "maximo" "igual")) (cons "maximo" 6)) 
(check-equal? (cadena-mayor '("hola")) (cons "hola" 4)) 

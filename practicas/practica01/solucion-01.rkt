;;
;; Solución práctica 1
;; 

#lang r6rs
(import (rnrs)
        (schemeunit))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 1: binario-a-decimal, binario-a-hexadecimal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; 1.a)

(define (binario-a-decimal b3 b2 b1 b0)
  (+ (* b3 (expt 2 3))
     (* b2 (expt 2 2))
     (* b1 (expt 2 1))
     (* b0 (expt 2 0))))

;; Pruebas

(display "Probando 'binario-a-decimal'\n")

(check-equal? (binario-a-decimal 1 1 1 1) 15)
(check-equal? (binario-a-decimal 0 0 0 0) 0)
(check-equal? (binario-a-decimal 0 1 1 0) 6)
(check-equal? (binario-a-decimal 0 0 1 1) 3)

; 1.b)

; Función decimal-a-hexadecimal

(define (decimal-a-hexadecimal decimal)
  (if (< decimal 10)
      (integer->char (+ decimal (char->integer #\0)))
      (integer->char (+ (- decimal 10) (char->integer #\A)))))

; Pruebas


(display "Probando 'decimal-a-hexadecimal'\n")
(check-equal? (decimal-a-hexadecimal 0) #\0)
(check-equal? (decimal-a-hexadecimal 6) #\6)
(check-equal? (decimal-a-hexadecimal 15) #\F)



; Función binario-a-hexadecimal

(define (binario-a-hexadecimal b3 b2 b1 b0)
  (decimal-a-hexadecimal (binario-a-decimal b3 b2 b1 b0)))

; Pruebas

(display "Probando 'binario-a-hexadecimal'\n")
(check-equal? (binario-a-hexadecimal 0 0 0 0) #\0)
(check-equal? (binario-a-hexadecimal 0 1 1 0) #\6)
(check-equal? (binario-a-hexadecimal 1 1 1 1) #\F)


;-------------------
; Ejercicio 2: mayor
;-------------------

; Versión 1 con 3 comparaciones; también se podría hacer con un "cond"

(define (mayor-de-tres n1 n2 n3)
  (if (and (> n1 n2) 
           (> n1 n3)) 
      n1
      (if (> n2 n3) 
          n2
          n3)))

; Pruebas

(display "Probando 'mayor-de-tres'\n")

(check-equal? (mayor-de-tres 2 8 1) 8)
(check-equal? (mayor-de-tres 3 0 3) 3)
(check-equal? (mayor-de-tres 2 1 8) 8)


; Versión 2 con llamadas anidadas a una función "mayor" definida por nosotros
; que devuelve el mayor de 2 números

;; Función mayor

(define (mayor n1 n2)
  (if (> n1 n2)
      n1
      n2))

;; Pruebas

(display "Probando 'mayor'\n")

(check-equal? (mayor 2 4) 4)
(check-equal? (mayor 4 2) 4)

;; Función mayor-de-tres-v2

(define (mayor-de-tres-v2 n1 n2 n3)
  (mayor n1 (mayor n2 n3)))

;; Pruebas

(display "Probando 'mayor-de-tres-v2'\n")

(check-equal? (mayor-de-tres-v2 2 8 1) 8)
(check-equal? (mayor-de-tres-v2 3 0 3) 3)
(check-equal? (mayor-de-tres-v2 2 1 8) 8)


;---------------------------------------
; Ejercicio 3: Modelo de evaluación aplicativo y normal
;---------------------------------------

;; Orden aplicativo 

; (f (cuadrado (+ 2 1)) (+ 1 1)) ->
; (f (cuadrado 3) (+ 1 1)) ->
; (f (* 3 3) (+ 1 1)) ->
; (f 9 (+ 1 1)) ->
; (f 9 2) ->
; (+ (* 2 9) 2)) ->
; (+ 18 2) ->
; 20

(define (f x y)
    (+ (* 2 x) y))


;; Orden normal

; (f (cuadrado (+ 2 1)) (+ 1 1)) ->
; (+ (* 2 (cuadrado (+ 2 1))) (+ 1 1)) ->
; (+ (* 2 (* (+ 2 1) (+ 2 1))) (+ 1 1)) ->
; (+ (* 2 (* 3 3)) (+ 1 1)) ->
; (+ (* 2 9) (+ 1 1)) ->
; (+ 18 (+ 1 1)) ->
; (+ 18 2) ->
; 20


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 4: tirada-ganadora 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Función suma-dados

(define (suma-dados t)
  (+ (car t)
     (cdr t)))

;; Pruebas

(display "Probando 'suma-dados'\n")
(check-equal? (suma-dados (cons 2 4)) 6)
(check-equal? (suma-dados (cons 1 3)) 4)


(define (diferencia-con-7 t)
  (abs (- (suma-dados t)
          7)))

(define (tirada-ganadora t1 t2)
  (cond
     ((< (diferencia-con-7 t1) (diferencia-con-7 t2)) 1)
     ((> (diferencia-con-7 t1) (diferencia-con-7 t2)) 2)
     (else 0)))

;; Pruebas

(display "Probando 'tirada-ganadora'\n")

(check-equal? (tirada-ganadora (cons 1 3) (cons 1 6)) 2)
(check-equal? (tirada-ganadora (cons 1 5) (cons 2 2)) 1)
(check-equal? (tirada-ganadora (cons 3 4) (cons 3 4)) 0)
(check-equal? (tirada-ganadora (cons 6 2) (cons 3 3)) 0)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 5: dentro-alcance?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (cuadrado x)
  (* x x))


;
; Devuelve la distancia (en metros) entre dos barcos
; x1, y1, x2, y2: coordenadas del barco 1 y barco 2 (en metros)
;
(define (distancia x1 y1 x2 y2)
  (sqrt (+ (cuadrado (- x2 x1))
           (cuadrado (- y2 y1)))))

; Pruebas

; Necesitamos una función que permita comparar dos números
; reales con un margen de error. Usamos la función iguales-reales?
; definida en el ejercicio siguiente.
;
; Dos números reales son iguales si la diferencia entre
; ellos es menor que un margen de error muy pequeño (epsilon)

(define epsilon 0.0001)

(define (iguales-reales? x y)
  (< (abs (- x y)) epsilon))

(check-true (iguales-reales? (distancia 0 0 100 100) 141.42135))
(check-true (iguales-reales? (distancia -10 -10 20 40) 58.30951))

;
; Devuelve la duración del combustible de un torpedo a
; velocidad v (en km/h)
;
(define (duracion-combustible v)
  (/ 50000 (cuadrado v)))

; Pruebas

(check-true (iguales-reales? (duracion-combustible 60) 13.88888))
(check-true (iguales-reales? (duracion-combustible 100) 5))


;
; Convierte la velocidad de km/h a m/s
;
(define (a-m-seg km-hora)
  (/ (* km-hora 1000) 3600))

; Pruebas

(check-true (iguales-reales? (a-m-seg 60) 16.66666))
(check-true (iguales-reales? (a-m-seg 100) 27.7777))


;
; Devuelve el alcance (en metros) de un torpedo a velocidad
; v (en km/h)
;
(define (alcance-torpedo v)
  (* (a-m-seg v) (duracion-combustible v)))


; Pruebas
(check-true (iguales-reales? (alcance-torpedo 60) 231.48148))
(check-true (iguales-reales? (alcance-torpedo 100) 138.8888))


; Devuelve si el barco situado en (x2, y2) (en metros)
; está dentro del alcance de un torpedo lanzado desde
; el barco (x1, y1) (en metros) a velocidad v (en km/h)

(define (dentro-alcance? x1 y1 x2 y2 v)
   (< (distancia x1 y1 x2 y2) (alcance-torpedo v)))


;; Pruebas

(display "Probando 'dentro-alcance?'\n")

(check-false (dentro-alcance? 0 0 500 500 30))
(check-true (dentro-alcance? 100 200 500 500 20))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 6: tipo-triangulo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
; Devuelve la distancia euclídea entre dos coordenadas
; representadas por dos parejas cada una con la posición
; x e y
;
(define (distancia-coords p1 p2)
  (distancia (car p1) (cdr p1) (car p2) (cdr p2)))


(define (tres-lados-iguales? v1 v2 v3)
  (and (iguales-reales? (distancia-coords v1 v2) (distancia-coords v2 v3))
       (iguales-reales? (distancia-coords v1 v2) (distancia-coords v3 v1))))

(define (dos-lados-iguales? v1 v2 v3)
  (or (iguales-reales? (distancia-coords v1 v2) (distancia-coords v2 v3))
      (iguales-reales? (distancia-coords v1 v2) (distancia-coords v3 v1))
      (iguales-reales? (distancia-coords v2 v3) (distancia-coords v3 v1))))

(define (tipo-triangulo v1 v2 v3)
  (cond ((tres-lados-iguales? v1 v2 v3) "equilatero")
        ((dos-lados-iguales? v1 v2 v3) "isosceles")
        (else "escaleno")))


;; Pruebas

(display "Probando 'tipo-triangulo'\n")

(check-equal? (tipo-triangulo (cons 1 1) (cons  1 6) (cons 6 1)) "isosceles")
(check-equal? (tipo-triangulo (cons -2 3) (cons  2 6) (cons 5 3)) "escaleno")
(check-equal? (tipo-triangulo (cons -3 0) (cons  3 0) (cons 0 5.1961)) "equilatero")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Ejercicio 7: calculadora
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (operador expresion)
   (car expresion))

(define (primer-numero expresion)
   (car (cdr expresion)))

(define (segundo-numero expresion)
   (car (cdr (cdr expresion))))

(define (calculadora expr)
  (cond
    ((equal? (operador expr) #\+) (+ (primer-numero expr)
                                      (segundo-numero expr)))
    ((equal? (operador expr) #\*) (* (primer-numero expr)
                                      (segundo-numero expr)))
    ((equal? (operador expr) #\-) (- (primer-numero expr)
                                      (segundo-numero expr)))
    (else (/ (primer-numero expr)
             (segundo-numero expr)))))

;; Pruebas

(display "Probando 'calculadora'\n")

(check-equal? (calculadora (list #\+ 2 3)) 5)
(check-equal? (calculadora (list #\* 3 4)) 12)
(check-equal? (calculadora (list #\- 7 4)) 3)
(check-equal? (calculadora (list #\/ 6 3)) 2)

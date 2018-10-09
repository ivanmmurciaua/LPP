// Tipos de datos \\

// Valores simples \\

var miVariable = 42
miVariable = 50

print(miVariable) //50

let miVariablex = 73
//miVariablex = 50   //ERROR, una variable constante no se puede mutar

print(miVariablex) // 73

// Escribir un tipo explicito

let explicitoInt: Int
explicitoInt=29
//explicitoInt=39     //ERROR
print(explicitoInt)  // 29

// Arrays 

//Crea un array de Ints vacio, un poco inutil  //Como yo xd
let arrayVacio=[Int]()										

//Crea un array con 10 ceros
let arrayCon100s=Array(repeating:0, count:10)               

var Avengers = ["Iron Man","Viuda Negra","Capi","Hulk","Ojo de Halcón"]

// Muestra a Tony
print(Avengers[0]) 

//Muestra a todos los vengadores
for x in 0..<Avengers.count{
	print(Avengers[x])
}

//Quita a Tony
print(Avengers.dropFirst())

// Diccionarios

// Gugul, Guguel o Gogle?

let diccionarioVacio = [String:Int]()

let avengersNombre = [
//     Key     :    Value
	"Iron Man" : "Tony Stark",
	"Capi"     : "Steve Rogers",
	"Hulk"     : "Bruce Banner",
]

//Estás seguro
print("Iron man se llama \(avengersNombre["Iron Man"]!).")

//No estoy seguro que esté
if let Iron=avengersNombre["Iron Man"]{
  print("Iron man se llama \(Iron)")
}

for x in avengersNombre{
  print("\(x.key) se llama \(x.value)")
}

// Tuplas

// El tipo es (Int:String)
let http = (404, "not found")

let (statusCode,statusMessage) = http

//Por variable de esa rara
print("Error \(statusCode) page \(statusMessage)")
//Por posición
print("Error \(http.0) page \(http.1)")


// Opcionales

let nombrePila: String? = nil
let apellido: String? = "Martinez"
let nombreDefecto: String = "Antonio"
let saludo = "¿Que tal, \(nombrePila ?? nombreDefecto)?"    //Si nombrePila==nil, muestra nombreDefecto, else, nombrePila

print(saludo + " " + apellido!)
//print(apellido!)        //Forma de imprimir SI NO es nil, una variable opcional

//Desenvoltura forzosa

if apellido != nil {
	print("Hola \(nombreDefecto) \(apellido!)")
}



// Estructuras de flujo \\

//If

if 1 > 0 {
	print("Sip")

} 
else {
	print("Nop")
}

/* Usar if y let para trabajar con valores que pueden faltar. Estos son opcionales. O bien contiene un valor o nil.
** Escribir una ? después del tipo de valor para marcar el valor como opcionales
*/

var cadenaOpcional: String? = "Hey Listen"
print(cadenaOpcional==nil)  //false

if let cadena = cadenaOpcional {
	print("Llena")
}
else{
	print("Vacia")
}

//Switch

let verdura: String="tomates"
switch verdura{
	case "zanahoria": print("Buena para la vista.")
	case "lechuga","tomates" : print("Buena ensalda pri")
	default: print("Pues haz una sopa nn")
}

//For-in

for x in 0...10{
	print(x)
}

for x in 0..<11{
	print(x)
}

for x in 0..<Avengers.count{
	print(Avengers[x])
}

for x in Avengers[0..<Avengers.count]{
	print(x)
}

//While

var n=2

while n < 6{
	n *= 2
}

print(n)

//Repeat while (Do While)

var m=2

repeat{
	m *= 2
}while m < 6

print(m)

// Enumeraciones

enum Direcciones{
	case norte,sur,este,oeste
}

let direccionAtardecer = Direccion.oeste.rawValue

let hemosGirado: Bool = true;
var direccionActual = Direcciones.norte
if hemosGirado { direccionActual = .oeste }

switch direccionActual{
	case .norte: print("Norte")
	case .sur: print("Sur")
	case .este: print("Este")
	case .oeste : print("Vaqueros")
}

// Valores brutos de enumeraciones

enum CaracterControlASCII: Character {
	case tab = "\t"
	case lineFeed = "\n"
	case carriageReturn = "\r"
}

let nuevalinea = CaracterControlASCII.lineFeed.rawValue

enum Planeta: Int {
	case mercurio=1,venus,tierra,marte,jupiter,saturno,urano,neptuno
}

let posicionTierra = Planeta.tierra.rawValue

let posiblePlaneta = Planeta(rawValue: 7)
print(posiblePlaneta!)

// Enum recursivo

indirect enum ExpresionArit{
	case numero(Int)
	case suma(ExpresionArit, ExpresionArit)
	case resta(ExpresionArit, ExpresionArit)
	case mult(ExpresionArit, ExpresionArit)
}

func evaluar(_ expresion: ExpresionArit) -> Int {
	switch expresion{
		case let .numero(valor)         : return valor
		case let .suma(primer,segundo)  : return evaluar(primer) + evaluar(segundo)
		case let .resta(primer,segundo) : return evaluar(primer) - evaluar(segundo)
		case let .mult(primer,segundo)  : return evaluar(primer) * evaluar(segundo)
	}
}

let cinco     = ExpresionArit.numero(5)
let cuatro    = ExpresionArit.numero(4)
let suma      = ExpresionArit.suma(cinco,cuatro)
let multip	  = ExpresionArit.mult(suma,cinco)

print(evaluar(suma))
print(evaluar(multip))

//Typealias - nombre asignado a cualquier tipo

/*
typealias Resultado = (Int, Int)

enum Quiniela{
	case Uno = "1"
	case Equis = "X"
	case Dos = "2"
}

func quiniela(_ res: Resultado) -> Quiniela {
	switch res{
		case let (goleslocal,golesvisitante) where goleslocal < golesvisitante : return .Dos.rawValue
		case let (goleslocal,golesvisitante) where goleslocal > golesvisitante : return .Uno.rawValue
		default : return .Equis.rawValue
	}
}

//print("Bayern München - Real Madrid \(quiniela((1,3)))")    //Bayern München - Real Madrid
print(quiniela((1,3)))
//print("Betis - Sevilla  \(quiniela((2,2)))")   //Betis - Sevilla
print(quiniela((2,2)))
//print("Real Madrid - Juventus \(quiniela((4,1)))")  //Real Madrid - Juventus
print(quiniela((4,1)))
*/

typealias Resultado = (Int, Int)

enum Quiniela{
	case Uno,X,Dos
}

func quiniela(_ res: Resultado) -> Quiniela {
	switch res{
		case let (goleslocal,golesvisitante) where goleslocal < golesvisitante : return .Dos
		case let (goleslocal,golesvisitante) where goleslocal > golesvisitante : return .Uno
		default : return .X
	}
}

print("Real Madrid - Juventus \(quiniela((4,1)))")  //Real Madrid - Juventus
print("Betis - Sevilla \(quiniela((2,2)))")   //Betis - Sevilla
print("Bayern München - Real Madrid \(quiniela((1,3)))")    //Bayern München - Real Madrid
//print(quiniela((1,3)))
//print(quiniela((2,2)))
//print(quiniela((4,1)))


// Definición de una función en Swift \\

// func prueba(ARGUMENTOS) -> SALIDA {}

/* ARGUMENTOS: (_ x: Int) (x: Int) LLAMADA prueba(3) prueba(x:3)
** SALIDA: -> Int, ->String, ->[Int] etc...
*/

func saludamecapullo(_ nombre: String, con anyos: Int, de ciudad: String) -> String {
	return "Hola \(nombre)!!. Tienes \(anyos) años y eres de \(ciudad)."
}

print(saludamecapullo("Iván",con:21,de:"Orihuela"))

/* En la documentación se usan las etiquetas separadas por dos puntos
** saludamecapullo(_:con:de:).
*/

// Función que recibe indeterminados parametros

func suma(numeros: Int...) -> Int{
	var suma: Int = 0;
	for numero in numeros{
		suma += numero
	}
	return suma
}

print(suma(numeros: 42,34,56,78,222))


// Definición de un void en Swift : Función sin salida \\

func saluda(_ nombre: String){
	print("Hola \(nombre)!!")
}

saluda("Ivan")

// Funciones que reciben otras funciones \\

func suma2ints(_ x: Int, _ y: Int) -> Int{return x+y}

func printRes(funcion: (Int, Int) -> Int, _ a: Int, _ b: Int){
	print("Resultado: \(funcion(a,b))")
}

printRes(funcion:suma2ints,3,2)


// División de una función en funciones

func devuelve33() -> Int{
	var x=22;
	func suma(){
		x += 11
	}
	suma()
	return x;
}

print(devuelve33())

// Funciones que devuelven otras funciones \\

func makeSumador10() -> (Int) -> Int {
	func suma10(x: Int) -> Int {return x+10}
	return suma10
}

var f = makeSumador10()
print(f(20))

// Clausuras

var numeros = [20,39,7,12]

/*numeros.map({
(numero: Int) -> Int in
let resultado = 3 * numero
return resultado
})*/

let numerosMapeados = numeros.map({ numero in 3 * numero})
print(numerosMapeados)

print(numeros.sorted{ $1 > $0 })
print(numeros.sorted{ $0 > $1 })














struct CoordsPantalla{
    var posX = 0
    var posY = 0
}

let a = CoordsPantalla()

struct CoordsPantalla1{
    posX = 0
    posY = 0
}
let Coordenadas1 = CoordsPantalla1(posX: 2,posY: 5)  //SOlo estructuras

//  Estructuras y demás tipos (Semantica de copia) var mutable, let inmutable

let cord1 = CoordsPantalla1(posX: 2,posY: 5)
var cord2 = cord1

//Son iguales
print(cord2)
print(cord1)


//  Clases y clausuras     (Semantica de referencia)  var y let mutables

/*class Ventana {
    var esquina = CoordsPantalla()
    var altura = 0
    var anchura = 0
    var visible = true
    var etiqueta: String?
}*/

class B{
	var x = 3
	var y = 5
}

//Distintos (puntero de d a c, si cambia c cambia d)
var c = B()
var d = c
c.x = 300
d

// Operadores de identidad

// Para saber si dos instancias tienen la misma referencia (===) viceversa (!==)

// Propiedades almacenadas

struct RangoLongitudFija{
	var primerValor: Int
	let longitud: Int
}

var rangode3 = RangoLongitudFija(primerValor: 4, longitud: 5)

rangode3.primerValor = 100
// rangode3.longitud = 343   //Error let

let bb = RangoLongitudFija(primerValor: 45, longitud: 894)
// bb.primerValor = 389 //ERROR ES LET Y SON INMUTABLES

//Propiedades calculadas  proporcionan un getter y un opcional setter

struct Punto{
	var x = 0.0, y = 0.0
}

struct Tamaño{
	var ancho = 0.0, alto = 0.0
}

struct Rectangulo{
	var origen = Punto()
	var tamaño = Tamaño()
	var centro: Punto{
		get{
			let centroX = origen.x + (tamaño.ancho / 2) 
			let centroY = origen.y + (tamaño.alto / 2)
			return Punto(x: centroX, y:centroY)
		}
		set{
			origen.x = centroNuevo.x - (tamaño.ancho /2)  //newValue.x
			origen.y = centroNuevo.y - (tamaño.alto / 2)  //newValue.y
		}
	}
}

var cuadrado = Rectangulo(origen: Punto(x: 0.0, y: 0.0),
                  tamaño: Tamaño(ancho: 10.0, alto: 10.0))
let centroCuadradoInicial = cuadrado.centro
cuadrado.centro = Punto(x: 15.0, y: 15.0)
print("cuadrado.origen está ahora en (\(cuadrado.origen.x), \(cuadrado.origen.y))")
// Prints "cuadrado.origen está ahora en (10.0, 10.0)"

// Si no se pone un set, se puede oprimir el get

/*
** var centro: Punto{
** 					return Punto(x: origen.x + (tamaño.ancho / 2), y: origen.y + (tamaño.alto / 2))
**}
*/

// WillSet (antes de mutarlo) y didSet(después de mutarlo)

class ContadorPasos {
    var totalPasos: Int = 0 {
        willSet(nuevoTotalPasos) {
            print("A punto de actualizar totoalPasos a \(nuevoTotalPasos)")
        }
        didSet {
            if totalPasos > oldValue  {
                print("Añadidos \(totalPasos - oldValue) pasos")
            }
        }
    }
}

struct A{
	static var propiedadAlmacenada = "Valor"
	static var propiedadCalculada: Int{
		return 1
	}
}

class Contador{
	var veces = 0
	func incrementa(){
		self.veces += 1
	}
}

let contador = Contador()
contador.incrementa() //1

// En las estructuras y enums y tal, los métodos no pueden modificar propiedades...perooo


struct Punto{
	var x = 0.0, y = 0.0
	mutating func incrementa(){
		self.x += 1.0
		self.y += 1.0
	}
}

var unPunto = Punto(x: 1.0, y: 1.0)
unPunto.incrementa(incX: 2.0, incY: 3.0)
print("El punto está ahora en (\(unPunto.x), \(unPunto.y))")  //2.0 2.0


// HERENCIA \\
// No hay clases padres como en java y tampoco abstractas

class Vehiculo {
    var velocidadActual = 0.0
    var descripcion: String {
        return "viajando a \(velocidadActual) kilómetros por hora"
    }
    func hazRuido() {
        // no hace nada - un vehículo arbitrario no hace ruido necesariamente
    }
}

class Calesa: Vehiculo {
	var caballos: Int = 0
    var tieneConductor = true
    override var descripcion: String(){
    	return super.descripcion + "con \(self.caballos) caballos."
    }
    override func hazRuido(){
    	print("IIIIIIIH BRRRRRRR")

    }
}

class CalesaAutomatica: Calesa {
    override var velocidadActual: Double {
        didSet {
     	   caballos = 5
        }
    }
}

let automatico = CalesaAutomatica()
automatico.velocidadActual = 100.0
print("CalesaAutomatica: \(automatico.descripcion)")
//print("CalesaAutomatica: \(automatico)")

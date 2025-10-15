import cosas.*

object camion {
	var property cosas = #{}
	const tara = 1000 
	method cargar(unaCosa) {
		self.validarCarga(unaCosa)
		cosas.add(unaCosa)
	}
	method validarCarga(cosa){
		if (!cosas.filter({objeto => objeto == cosa}).isEmpty()){
			self.error("El objeto ya esta cargado")
		}
	}
	method descargar(cosa) {
		self.validarDescarga(cosa)
	  	cosas.remove(cosa)
	}
	method validarDescarga(cosa){
		if (cosas.filter({objeto => objeto == cosa}).isEmpty()){
			self.error("El objeto no esta cargado")
		}
	}
	method todoPesoPar() {
	  return cosas.filter({objeto => objeto.peso() % 2 == 0}).size() == cosas.size()
	}
	method hayAlgunoQuePesa(cantidad){
	  return !cosas.filter({objeto => objeto.peso() == cantidad}).isEmty()			
	}

	method peso(){
		return cosas.sum({objeto => objeto.peso()}) + tara
	}

	method estaExcedido(){
		return self.peso() > 2500
	}
	method hayAlgunoDePeligrosidad(nivel){
		if (cosas.filter({objeto => objeto.nivelPeligrosidad() == nivel}).isEmpty()){
			self.error("No hay ningun objeto con ese nivel de peligrosidad")
		} else {
			return cosas.filter({objeto => objeto.nivelPeligrosidad() == nivel})
		}
		
	}

	method peligrosidadMayorQue(nivelDePeligrosidad){
		return cosas.filter({objeto => objeto.nivelPeligrosidad() > nivelDePeligrosidad})
	}

	method esMasPeligrosoQue(cosa){
		return self.peligrosidadMayorQue(cosa.nivelPeligrosidad())
	}

	method puedeCircularEnRuta(nivelDePeligrosidad){
		return self.estaExcedido() && self.peligrosidadMayorQue(nivelDePeligrosidad).isEmpty()
	}
	
	method tieneAlgoQuePesaEntre (cantidad1, cantidad2){
		return cosas.filter({objeto => objeto.peso() >= cantidad1 && objeto.peso() <= cantidad2}).isEmpty()
	}
	method cosaMasPesada(){
		if (self.estaVacio(cosas)){
			self.error("El camion esta vacio")
		}
		return cosas.max({objeto => objeto.peso()})
	}
	method estaVacio(lista){
		return lista.isEmpty()
	}
	method pesos(){
		return cosas.map({objeto => objeto.peso()})
	}
	method bultosTotales(){
		return cosas.sum({objeto => objeto.bultos()})
	}
	method accidente(){
		self.cosas().forEach({elemento => elemento.accidente()})
	}
	method transportar (destino,camino){
		camino.puedeCircular()
		destino.cargarTodo()
	}
}

object almacen{
	var property cosasAlmacen = #{}
	method cargarTodo(){
		camion.cosas().forEach({elemento => self.cargar(elemento)})
		camion.cosas().clear()
	}
	method cargar(unaCosa){
		self.validarCarga(unaCosa)
		cosasAlmacen.add(unaCosa)
	}
	method validarCarga(cosa){
		if (cosasAlmacen.filter({objeto => objeto == cosa}).size()>0){
			self.error("El objeto ya esta cargado")
		}
	}
}

object ruta9{
	method puedeCircular(){
		if(camion.peligrosidadMayorQue(20).size()>0 || camion.estaExcedido()){
			self.error("no se puede realizar el viaje porque excedió la peligrosidad o superó el peso")
		}
	}
}

object caminosVecinales{
	var property pesoMaximo = 0
	method puedeCircular(){
		if (camion.peso()>pesoMaximo){
			self.error("No puede realizarse el viaje por caminos vecinales, se superó el límite de peso permitido")
		}
	}
} 


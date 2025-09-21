object knightRider {
	var peligrosidad = 10
	var property bultos = 1
	method peso() { return 500 }
	method nivelPeligrosidad() { return peligrosidad }
	method embalar(){
		peligrosidad = peligrosidad / 2
		bultos += 2
	}
	method desembalar(){
		peligrosidad = peligrosidad * 2
		bultos -= 2
	}
	method accidente(){

	}
 }

 object arenaAGranel {
	var peligrosidad = 1
	var property bultos = 1
	var property peso = 0
	method nivelPeligrosidad() { return peligrosidad }
	method embalar(){ 
		bultos += 2
		peligrosidad = peligrosidad / 2
	}
	method desembalar(){
		peligrosidad = peligrosidad * 2
		bultos -= 2
	}
	method accidente() {
		peso += 20
	}
 }

 object bumblebee {
	var property bultos = 2
	var peligrosidad = 0
	var property estado = self.auto()
	method peso() { return 800 }
	method calcularPeligrosidad() { 
		if (estado == self.robot()) {
			peligrosidad = 30			
		} else {
			peligrosidad = 15			
		}
	}	
	method nivelPeligrosidad() { 
		return peligrosidad 
	}
	method robot(){
		return 2
	}
	method auto(){
		return 1
	}
	method embalar(){
		peligrosidad = self.nivelPeligrosidad()/2
		bultos += 2
	}
	method desembalar(){
		peligrosidad = peligrosidad*2
		bultos -= 2
	}
	method accidente(){
		if (estado == self.auto()){
			estado = self.robot()
		} else {
			estado = self.auto()
		}
	}
 }
 

 object paqueteDeLadrillos {
	var property bultos = 1
	var peligrosidad = 2
	var property cantidadLadrillos = 0
	method peso() { return cantidadLadrillos*2 }
	method nivelPeligrosidad() { return peligrosidad }
	method calcularBultos(){
		if (cantidadLadrillos.between(101, 300)) {
			bultos = 2
		} else {
			if (cantidadLadrillos > 300) {
				bultos = 3
			} 
		}
	}
	method embalar(){ 
		peligrosidad = peligrosidad/2
		bultos += 2
	}
	method desembalar(){ 
		peligrosidad = peligrosidad*2
		bultos -= 2
	}
	method accidente(){
		if (self.cantidadLadrillos()>=12){
			cantidadLadrillos -= 12
		} else {
			cantidadLadrillos-= cantidadLadrillos
		}
	}
 }

 object bateriaAntiaerea {
	var property bultos = 1
	var peligrosidad = 0
	var property estaConMisiles = false 
	method peso() { 
		if (estaConMisiles) {
			return 300
		} else {
			return 200
		}
	 }
	method calcularBultos() {
		if (estaConMisiles) {
			bultos = 2
		} else {
			bultos = 1
		}
	}
	method calcularPeligrosidad() { 
		if (estaConMisiles) {
			peligrosidad = 100
		} else {
			peligrosidad = 0
		}
	 }
	method nivelPeligrosidad() { 
		return peligrosidad 
	}
	
	method embalar(){ 
		peligrosidad = peligrosidad/2 
		bultos += 2
	 }

	method desembalar(){ 
		peligrosidad = peligrosidad*2 
		bultos -= 2
	}
	method accidente(){
		estaConMisiles = false
	}
 }

 object residuosRadioactivos {
	var property bultos = 1
	var peligrosidad = 200
	var property peso = 0  
	method nivelPeligrosidad() { return peligrosidad }
	method embalar(){ 
		peligrosidad = peligrosidad/2 
		bultos += 2
	}
	method desembalar(){ 
		peligrosidad = peligrosidad*2 
		bultos -= 2
	}
	method accidente(){
		peso += 15
	}
 }

 object contenedorPortuario {
	var property cosas = #{}
	method cargar(unaCosa) {
		cosas.add(unaCosa)
	}
	method peso() {
		return 100 + cosas.sum({objeto => objeto.peso()})
	}
	method nivelPeligrosidad() {
		if (cosas.size() == 0) {
			return 0
		} else {
			return (cosas.max({objeto => objeto.nivelPeligrosidad()}).nivelPeligrosidad())
		}
	}
	method bultos() {
		return (cosas.sum({objeto => objeto.bultos()}) + 1)
	}
	method accidente(){
		self.cosas().forEach{elemento => elemento.accidente()}
	}
 }
import conocimientos.*
import cumbre.*

class Participante {
	var property pais
	var property commits = 0
	var property conocimientos = #{}
	
	method cumpleConLosRequisitos() {
		return conocimientos.contains(programacionBasica)
	} 

	// lo defino abstracto en la superclase
	// vale
	// la clase pasa a ser abstracta (probar hacer un new en el REPL)
	// es lo que queremos. Vamos a tener programadores, especialistas o gerentes,
	// no nos interesa tener "participantes genéricos"
	method esCape() 
	
	method agregarActividad(actividad) {
		// el tema de la actividad se incorpora a los conocimientos que ya tiene
		conocimientos.add(actividad.tema())
		// se agrega una cantidad de commits ...
//		commits = commits + actividad.tema().commitsPorHora() * actividad.horas()
		commits = commits + actividad.commitsQueDa()
	}
	
	// este es un agregado inventado en el momento
	// para pensar cuándo es necesario un método abstracto
	// si se habilita este método, entonces es necesario definir esCape() abstracto
//	method aprender() {
//		if (self.esCape()) {
//			conocimientos.add(disenioConObjetos)
//		} else {
//			commits = commits + 20
//		}
//	}
}

class Programador inherits Participante {
	var property horasDeCapacitacion = 0
	
	method esCape() { return commits > 500 }
	override method cumpleConLosRequisitos() {
		return super() and commits >= cumbre.commitsMinimosProgramador() 
	} 
	override method agregarActividad(actividad) {
		super(actividad)
		horasDeCapacitacion = horasDeCapacitacion + actividad.horas()
	}
}

class Especialista inherits Participante {
	method esCape() { return conocimientos.size() > 2 }
	override method cumpleConLosRequisitos() {
		return super() 
			and commits >= cumbre.commitsMinimosProgramador() - 100
			and conocimientos.contains(objetos)
	} 
}

class Gerente inherits Participante {
	var property empresa
	method esCape() { return empresa.esMultinacional() }
	override method cumpleConLosRequisitos() {
		return super() 
			and conocimientos.contains(manejoDeGrupos)
	} 
}

class Empresa {
	const property paises = #{}
	method esMultinacional() { return paises.size() >= 3 }
}

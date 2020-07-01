object cumbre {
	const property paisesAuspiciantes = #{}
	const property participantes = []
	var property commitsMinimosProgramador = 300
	const property actividadesRealizadas = #{}
	
	// esto esta muy mal malisimo
	// const property paisesDeLosParticipantes = []
	
	method agregarAuspiciante(pais) {
		paisesAuspiciantes.add(pais)
	}
	
	method agregarActividad(actividad) {
		actividadesRealizadas.add(actividad)
		participantes.forEach({ 
			parti => parti.agregarActividad(actividad)
		})
	}
	
	method totalHorasDeActividades() {
		return actividadesRealizadas.sum({ 
			actividad => actividad.horas()
		})
	}

	// se puede hacer aca, tambien se puede hacer en el pais
	// obviamente, no lo hagan en los dos
	// lo dejo comentado aca porque esta hecho en Pais
//	method esConflictivo(unPais) {
//		return self.paisesAuspiciantes().any({ 
//			pais => unPais.estaEnConflictoCon(pais)
//		})
//	}

	method ingresa(unParticipante) {
		participantes.add(unParticipante)
	}

	method paisesDeLesParticipantes() {
		return participantes.map({ parti => parti.pais() }).asSet()		
	}
	
	method cantidadDeParticipantes(pais) {
		return participantes.count({ parti => parti.pais() == pais })
	}
	
	// respuesta: un pais
	method paisConMasParticipantes() {
		return self.paisesDeLesParticipantes().max({ 
			pais => self.cantidadDeParticipantes(pais)
		})
	}
	
	method participantesExtranjeros() {
		return participantes.filter({ 
			parti => not paisesAuspiciantes.contains(parti.pais())
		})
	}

	method participantesExtranjeros_tranca() {
		return participantes.filter({ 
			parti => not self.esDePaisAuspiciante(parti)
		})
	}
	
	method esDePaisAuspiciante(participante) {
		return paisesAuspiciantes.contains(participante.pais())
	}
	
	method esRelevante() {
		return participantes.all({ parti => parti.esCape() })
	}
	
	method tieneRestringidoElAcceso(participante) {
		return participante.pais().esConflictivoParaLaCumbre()
			or
			not self.paisConCupo(participante.pais())
	}
	
	method paisConCupo(pais) {
		return paisesAuspiciantes.contains(pais)
			or
			self.cantidadDeParticipantes(pais) < 2
//			self.cantidadDeParticipantes(pais).between(0,1)
	}
	
	method puedeIngresar(participante) {
		return participante.cumpleConLosRequisitos()
			and not self.tieneRestringidoElAcceso(participante)
	}
	
	method darIngreso(participante) {
		if (self.puedeIngresar(participante)) {
			self.ingresa(participante)
		} else {
			self.error("No puede entrar")
		}
	}
	
	method esSegura() {
		return participantes.all({ 
			parti => self.puedeIngresar(parti)
		})
	}
}







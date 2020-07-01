import cumbre.*

class Pais {
	const property paisesConConflictos = #{}
	
	method agregarConflictoCon(otroPais) {
		paisesConConflictos.add(otroPais)
	}
	
	method esConflictivoParaLaCumbre() {
		return cumbre.paisesAuspiciantes().any({ 
			pais => self.estaEnConflictoCon(pais)
		})
	}
	
	method estaEnConflictoCon(otroPais) {
		return paisesConConflictos.contains(otroPais) 
	}

	method esConflictivoParaLaCumbre_todoJunto() {
		return cumbre.paisesAuspiciantes().any({ 
			pais => paisesConConflictos.contains(pais)
		})
	}
}

class Actividad {
	var property tema
	var property horas = 0
	
	method commitsQueDa() { return tema.commitsPorHora() * horas }
}
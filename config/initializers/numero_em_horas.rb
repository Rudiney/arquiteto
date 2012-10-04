class Fixnum
	def em_horas
		
		nr = self
		
		if nr < 0
			numero_negativo = true
			nr = self * -1
		end
		
		horas = nr / 1.hour
		minutos = (nr - horas.hours) / 1.minute
		
		return "#{(numero_negativo ? '-' : '')}#{horas}:#{minutos.to_s.rjust(2,'0')}"
	end
end
class String
	def em_segundos

		# se a string tem :
		if self.include? ':'
			#separa o tempo em horas e minutos
			horas,segundos = self.split(':')
						
			return horas.to_f.hours.to_i + segundos.to_f.minutes.to_i
		end
		
		# se a string termina com M
		if self.ends_with?('m','M')
			#o tempo é minutos
			return self.chop.to_f.minutes.to_i
		end
		
		# se a string termina com H
		if self.ends_with?('h','H')
			# o tempo é horas
			return self.chop.to_f.hours.to_i
		end

		return self.to_f.hours.to_i
	end
end
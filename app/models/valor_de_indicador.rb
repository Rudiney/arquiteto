# encoding: UTF-8

module ValorDeIndicador
	def valor_convertido
		return unless self.indicador
		
		case self.indicador.tipo
		when 'numero', 'duracao'
			return self.valor.to_f
		when 'data'
			return self.valor.to_date
		end
	end
end
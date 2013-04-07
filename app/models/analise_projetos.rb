# encoding: UTF-8

class AnaliseProjetos
	def projetos
		Projeto.all.delete_if do |projeto|
			Pesquisa.all.map{|p| projeto.satisfaz_pesquisa?(p)}.include?(false)
		end
	end
end

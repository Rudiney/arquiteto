# encoding: UTF-8

class CategoriaArquivoFonte < ActiveRecord::Base
	
	belongs_to :produto	
	
	validates :nome, :string_expressao_regular, :produto_id, presence: true
	validates :nome, :string_expressao_regular, length: { maximum: 255}
	validates :string_expressao_regular, uniqueness:{ scope: :produto_id}
	
	validate :valida_se_a_string_expressao_regular_e_valida
	validate :valida_se_o_produto_existe
	
	scope :do_produto, lambda{ |produto|
		where(produto_id: produto)
	}

	def nome_exibicao
		return "#{self.id}) #{self.nome}"
	end
	
	def expressao_regular
		Regexp.new(self.string_expressao_regular)
	end
	
	# Retorna os arquivos fontes em que o caminho completa bate com a expressão regular 
	# desta categoria
	def arquivos_fonte
		return ArquivoFonte.do_produto(self.produto).find_all do |af|
			self.expressao_regular.match(af.caminho_completo)
		end
	end
	
	private
	
	
	def valida_se_a_string_expressao_regular_e_valida
		return unless self.string_expressao_regular
		begin
			Regexp.new(self.string_expressao_regular)
		rescue
			self.errors.add(:string_expressao_regular,'não é uma expressão regular válida')
		end
	end
	
	def valida_se_o_produto_existe
		self.errors.add(:produto_id, 'não existe') unless Produto.exists?(self.produto_id)
	end
end
# encoding: UTF-8

class ArquivoFonte < ActiveRecord::Base

	validates :caminho_completo,:produto_id, presence: true
	validate :valida_se_o_produto_existe
	
	validates :caminho_completo, uniqueness: {scope: :produto_id}
	belongs_to :produto
	
	has_many :tarefas_arquivos_fonte, :class_name => 'TarefaArquivoFonte', :dependent => :destroy
	has_many :tarefas, :through => :tarefas_arquivos_fonte

	scope :do_produto, lambda{ |produto|
		where(produto_id: produto)
	}

	def nome
		@nome ||= self.caminho_completo.split('/').last
	end
	
	def diretorio
		@diretorio ||= self.caminho_completo.gsub("/#{self.nome}",'')
	end
	
	# Retorna todas as histórias deste arquivo fonte
	# 
	# 1 arquivo fonte pode pertencer a várias tarefas, cada tarefa pertence a 1 história. 
	# Este método retorna todas as historias do arquivo fonte
	def historias
		Historia.joins(tarefas: :arquivos_fonte).
		where(tarefas:{arquivos_fonte:{id: self}})
	end
	
	# Retorna todas as funcionalidades do arquivo fonte.
	# 
	# 1 arquivo fonte pode pertencer a várias tarefas, cada tarefa pertence a 1 história e 
	# cada história pode ter várias funcionalidades relacionadas. Este método retorna todas
	# as funcionalidades deste arquivo fonte.
	def funcionalidades
		Funcionalidade.joins(historias:{tarefas: :arquivos_fonte}).
		where(historia:{tarefas:{arquivos_fonte:{id: self}}})
	end
	
	def categorias
		CategoriaArquivoFonte.do_produto(self.produto).find_all do |c|
			c.expressao_regular.match(self.caminho_completo)
		end
	end
	
	private
	
	def valida_se_o_produto_existe
		self.errors.add(:produto_id,'não existe') unless Produto.exists?(self.produto_id)
	end
end
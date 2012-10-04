# encoding: UTF-8

class Funcionalidade < ActiveRecord::Base
	
	#relacionamentos com outra funcionalidade (um = self, dois = outra)
	has_many :relacionamentos_com, :class_name => "RelacaoFuncionalidades", :foreign_key => "funcionalidade_um_id",  :dependent => :destroy
	#relacionamentos de outra funcionalidade (um = outra, dois = self)
	has_many :relacionamentos_de, :class_name => "RelacaoFuncionalidades", :foreign_key => "funcionalidade_dois_id", :dependent => :destroy
	
	belongs_to :produto
	
	has_many :funcionalidade_historias, :class_name => "FuncionalidadeHistoria", :foreign_key => "funcionalidade_id", :dependent => :destroy
	has_many :historias, :through => :funcionalidade_historias
	
	before_validation :url_artigo_wiki_padrao

	validates :nome, :produto_id, :presence => true
	validate :valida_se_o_produto_existe
	
	scope :do_produto, lambda{ |produto|
		where(:produto_id => produto)
	}
	
	# O nome do artigo na wiki é o nome da funcionalidade separado por _ no lugar dos espaços
	# tem o prefixo Funcionalidade ID: Nome
	def nome_artigo_wiki
		"Funcionalidade #{self.id}: #{self.nome.to_s.gsub(' ','_')}"
	end

	def nome_exibicao
		return "#{self.id}) #{self.nome}"
	end
	
	def relacionamentos
		RelacaoFuncionalidades.da_funcionalidade(self)
	end
	
	# Como existe 2 tipos de relacioamentos, desta funcionalidade com outra, e de outra funcionalidade
	# com essa, este método retorna todas as funcionalidades relacionadas com esta independente
	# de que tipo seja este relacionamento
	def funcionalidades_relacionadas
		funcionalidades = []
		funcionalidades += self.relacionamentos_com.map{|r| r.funcionalidade_dois}
		funcionalidades += self.relacionamentos_de.map{|r| r.funcionalidade_um}
		return funcionalidades
	end
	
	def funcionalidades_nao_relacionadas
		funcionalidades_nao_relacionadas = (Funcionalidade.do_produto(self.produto).all - self.funcionalidades_relacionadas)
		funcionalidades_nao_relacionadas.sort!{|a,b| a.id <=> b.id}
		funcionalidades_nao_relacionadas.delete(self)
		return funcionalidades_nao_relacionadas
	end	
	
	# retorna somente a relação desta funcionalidade com outra
	# retorna false se não existe uma relação entre as duas funcionalidades
	def relacao_com(outra_funcionalidade)
		
		relacao_com = self.relacionamentos_com.where(funcionalidade_dois_id: outra_funcionalidade).first
		return relacao_com.relacao if relacao_com
		
		relacao_de = self.relacionamentos_de.where(funcionalidade_um_id: outra_funcionalidade).first
		return relacao_de.relacao if relacao_de
		
		return false
	end
	
	def arquivos_fonte
		ArquivoFonte.joins(tarefas:{historia: :funcionalidades}).
		where(tarefas:{historia:{funcionalidades:{id: self}}})
	end
	
	# Agrupa os arquivos fonte por categoria.
	# 
	# Como um arquivo fonte pode ter várias categorias, quando isso ocorre o arquivo fonte vai 
	# aparecer em dois grupos diferentes
	# 
	# Arquvos fonte sem categoria estarão na chave nil do hash
	def arquivos_fonte_agrupados_por_categoria
		return @arquivos_fonte_agrupados_por_categoria || agrupa_arquivos_fonte_por_categoria()		
	end
	
	# Funcionalidades relacionadas técnicamente são as funcionalidades que tem arquivos
	# fontes em comum. Então se um arquivo fonte pertence a duas 
	# funcionalidades diferentes, estas funcionalidades tem uma relação técnica entre si.
	# 
	# TODO: achar uma maneira de fazer tudo com 1 SQL só.
	def funcionalidades_relacionadas_tecnicamente
		funcionalidades = []
		
		self.arquivos_fonte.each do |af|
			funcionalidades += af.funcionalidades.where("funcionalidades.id NOT IN (?)",funcionalidades + [self])
		end
		
		return funcionalidades
		
	end
	
	private
	
	def valida_se_o_produto_existe
		self.errors.add(:produto_id, 'não existe!') unless Produto.exists?(self.produto_id)
	end
	
	def url_artigo_wiki_padrao
		return unless self.url_artigo_wiki.blank?
		return unless self.produto
		
		self.url_artigo_wiki = self.produto.url_base_wiki.to_s + self.nome_artigo_wiki
	end
	
	def agrupa_arquivos_fonte_por_categoria
		
		@arquivos_fonte_agrupados_por_categoria = {}
		
		self.arquivos_fonte.each do |af|
			
			if af.categorias.empty? 
				@arquivos_fonte_agrupados_por_categoria[nil] ||= []
				@arquivos_fonte_agrupados_por_categoria[nil] << af
				next
			end
			
			af.categorias.each do |cat|
				@arquivos_fonte_agrupados_por_categoria[cat] ||= []
				@arquivos_fonte_agrupados_por_categoria[cat] << af				
			end
		end
		
		return @arquivos_fonte_agrupados_por_categoria
	end
end
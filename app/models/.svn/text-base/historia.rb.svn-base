# encoding: UTF-8

class Historia < ActiveRecord::Base
	
	SITUACOES = {
		10 => :incompleta,
		20 => :aguardando,
		30 => :iniciada,
		40 => :pronta
	}
	
	OPCOES_TAMANHOS = [0,1,2,3,5,8]
	
	belongs_to :produto

	has_many :funcionalidade_historias, :class_name => "FuncionalidadeHistoria", :foreign_key => "historia_id", :dependent => :destroy
	has_many :funcionalidades, :through => :funcionalidade_historias

	has_many :anexos, :class_name => "HistoriaAnexo", :foreign_key => "historia_id"
	has_many :tarefas, :dependent => :destroy

	belongs_to :pacote
	
	validates :nome, :produto_id, :situacao, presence: true
	validates :nome, length: { maximum: 255}
	validates :situacao, inclusion: {in: Historia::SITUACOES.keys}
	validates :complexidade_negocio, :complexidade_interface, :esforco, :risco, numericality: true
	validates :complexidade_negocio, :complexidade_interface, :esforco, :risco, inclusion:{ in: Historia::OPCOES_TAMANHOS}
	
	validate :valida_se_o_produto_existe
	validate :valida_se_o_pacote_existe
	validate :o_pacote_deve_ser_do_mesmo_produto

	before_save :reprioriza_historias
	
	scope :do_produto, lambda{ |p|
		where(produto_id: p)
	}
	
	# este escopo filtras as histórias em uma determinada situaçào,
	# a quipode receber tanto o código da situação quanto o seu nome
	# pode tbm receber váiras situações
	scope :na_situacao, lambda{ |*codigo_ou_nome|
		
		situacoes = Historia::SITUACOES.find_all do |codigo,nome|
			codigo_ou_nome.include?(codigo) || codigo_ou_nome.include?(nome)
		end
		
		situacoes.collect!{ |s| s.first}
		
		where(situacao: situacoes)
	}
	
	def initialize(*options)
		super
		
		self.descricao = self.descricao || "Como um [usuario] gostaria de [funcionalidade] para [objetivo]"
	end

	def tamanho
		self.complexidade_negocio + self.complexidade_interface + self.esforco + self.risco
	end
	
	def nome_exibicao
		return "#{self.id}) #{self.nome}"
	end

	def situacao_nome
		Historia::SITUACOES[self.situacao]
	end
		
	#retorna as funcionalidades que esta historia ainda nao tem relacao
	def funcionalidades_nao_relacionadas
		return (Funcionalidade.do_produto(self.produto) - self.funcionalidades).sort{|a,b| a.id <=> b.id}
	end

	# é a soma das estimativas de todas as suas tarefas
	def segundos_estimados
		self.tarefas.sum(:segundos_estimados)
	end
	
	# é a soma do tempo real de todas as suas tarefas
	def segundos_reais
		self.tarefas.sum(:segundos_reais)
	end

	def tempo_estimado
		self.segundos_estimados.em_horas
	end
	
	def tempo_real
		self.segundos_reais.em_horas
	end
	
	def segundos_diferenca_estimativa
		self.segundos_estimados - self.segundos_reais
	end

	def diferenca_estimativa
		self.segundos_diferenca_estimativa.em_horas
	end

	def arquivos_fonte
		ArquivoFonte.joins(:tarefas_arquivos_fonte => :tarefa).
		where(:tarefas => { :historia_id => self.id })
	end
	
	private
	
	def reprioriza_historias
		return unless self.prioridade_changed?
		proximas_historias = self.produto.historias.where(prioridade: self.prioridade).order('updated_at')
		proximas_historias.each do |ph|
			ph.prioridade = self.prioridade + 1
			ph.save!
		end
	end

	def valida_se_o_produto_existe
		self.errors.add(:produto_id, 'não existe!') unless Produto.exists?(self.produto_id)
	end
	
	def valida_se_o_pacote_existe
		return unless self.pacote_id
		self.errors.add(:pacote_id, 'não existe!') unless Pacote.exists?(self.pacote_id)
	end
	
	def o_pacote_deve_ser_do_mesmo_produto
		return unless self.pacote
		self.errors.add(:pacote_id, 'deve ser do mesmo produto da história') unless self.produto == self.pacote.produto
	end
	
end
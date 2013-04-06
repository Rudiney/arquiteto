module Crud
	
	def initialize
		super
		@modelo        = self.class.name.gsub('Controller','').underscore.singularize.camelcase.constantize unless @modelo
		@nome_singular = @modelo.to_s.underscore
		@nome_plural   = @modelo.to_s.underscore.pluralize
	end
	
	def index
		busca_lista
	end
	
	def show
		busca_lista
		params[:selecionar] = params[:id]
		render(action: 'index')
	end
	
	def new
		novo_registro()
		carrega_variaveis()
		before_render_new()
		respond_to do |f|
			f.html{ render('new')}
			f.js{ render('crud/exibe_form') }
		end
	end
	
	def create
		novo_registro(params[@nome_singular.to_sym])
		before_create
		@registro.save ? render_que_salvou : render_que_nao_salvou
	end
	
	def edit
		busca_registro()
		return unless @registro
		
		carrega_variaveis()
		respond_to do |f|
			f.html{ render('edit')}
			f.js  { render('crud/exibe_form') }
		end
	end
	
	def update
		busca_registro()
		return unless @registro
		@registro.update_attributes(params[@nome_singular.to_sym]) ? render_que_salvou : render_que_nao_salvou
	end
	
	def destroy
		busca_registro()
		return unless @registro
		
		@registro.destroy
		
		respond_to do |f|
			f.html{ redirect_to(action: :index) }
			f.js{ js_redirect_to(action: :index)}
		end
	end
	
	protected
	
	def busca_lista
		set(@nome_plural,@modelo.order(:id))
	end
	
	def busca_registro
		set(@nome_singular,@modelo.find(params[:id]))
		@registro = get(@nome_singular)
	end
	
	def novo_registro(atributos={})
		set(@nome_singular,@modelo.new(atributos))
		@registro = get(@nome_singular)
	end
	
	def set(nome,valor)
		instance_variable_set("@#{nome}",valor)
	end
	
	def get(nome)
		instance_variable_get("@#{nome}")
	end
	
	def render_que_salvou
		respond_to do |f|
			f.html{redirect_to(@registro)}
			f.js{ js_redirect_to(url_for(@registro))}
		end
	end
	
	def render_que_nao_salvou
		carrega_variaveis()
		respond_to do |f|
			f.html{render(action: :edit)}
			f.js{ render('crud/exibe_form')}
		end
	end

	def carrega_variaveis
	end
	
	def before_create
	end
	
	def before_render_new
	end
end
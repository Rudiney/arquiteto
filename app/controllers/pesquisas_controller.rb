class PesquisasController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	def index
		@pesquisa = Pesquisa.new
		@pesquisas = Pesquisa.all
		@analise = AnaliseProjetos.new
	end

	def show
		@pesquisas = Pesquisa.all
	end

	def new
		@pesquisa = Pesquisa.new
	end

	def edit
		@projeto = Projeto.find(params[:id])
		@indicadores = IndicadorProjeto.where('projeto_id = ?', @projeto.id)
	end

	def create
	  
		params[:pesquisa][:operador] = params[:pesquisa][:operador].to_i
	  
		@pesquisa = Pesquisa.new(params[:pesquisa])
		
		respond_to do |format|
			if @pesquisa.save
				format.html { redirect_to action: ''}
			else
				format.html { render action: "new" }
				format.json { render json: @pesquisa.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@pesquisa = Pesquisa.find(params[:id])

		respond_to do |format|
			if @pesquisa.update_attributes(params[:produto])
				format.html { redirect_to @pesquisa, notice: 'Produto was successfully updated.' }
				format.json { head :ok }
			else
				format.html { render action: "edit" }
				format.json { render json: @pesquisa.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@pesquisa = Pesquisa.find(params[:id])
		@pesquisa.destroy

		respond_to do |format|
			format.html { redirect_to pesquisas_url }
			format.json { head :no_content }
		end
	end
	
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'pesquisa'
	end
	
end

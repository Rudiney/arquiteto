class ProjetosController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	def index
		@projetos = Projeto.all
	end

	def show
		@projeto = Projeto.find(params[:id])
	end

	def new
		@projeto = Projeto.new
	end

	def edit
		@projeto = Projeto.find(params[:id])
	end

  def cadastrar_indicadores
    @projeto = Projeto.find(params[:id])
    @indicador_projeto = IndicadorProjeto.new
    @indicadors = Indicador.all
  end

	def create
		@projeto = Projeto.new(params[:projeto])

		respond_to do |format|
			if @projeto.save
				format.html { redirect_to action: 'cadastrar_indicadores/' + @projeto.id.to_s }
			else
				format.html { render action: "new" }
				format.json { render json: @projeto.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@projeto = Projeto.find(params[:id])

		respond_to do |format|
			if @projeto.update_attributes(params[:produto])
				format.html { redirect_to @projeto, notice: 'Produto was successfully updated.' }
				format.json { head :ok }
			else
				format.html { render action: "edit" }
				format.json { render json: @projeto.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@projeto = Projeto.find(params[:id])
		@projeto.destroy

		respond_to do |format|
			format.html { redirect_to projetos_url }
			format.json { head :no_content }
		end
	end
	
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'projeto'
	end
	
end

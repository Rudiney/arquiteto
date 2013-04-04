class IndicadorsController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	def index
		@indicadors = Indicador.all
	end

	def show
		@indicador = Indicador.find(params[:id])
	end
  
	def new
		@indicador = Indicador.new
	end

	def edit
		@indicador = Indicador.find(params[:id])
	end

  def cadastrar_indicadores
    @indicador = Indicador.find(params[:id])
    @indicador_projeto = IndicadorProjeto.new
    @projetos = Projeto.all
  end
  
	def create
		@indicador = Indicador.new(params[:indicador])

		respond_to do |format|
			if @indicador.save
			  format.html { redirect_to action: 'cadastrar_indicadores/' + @indicador.id.to_s }
			else
				format.html { render action: 'new' }
				format.json { render json: @indicador.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@indicador = Indicador.find(params[:id])

		respond_to do |format|
			if @indicador.update_attributes(params[:indicador])
				format.html { redirect_to @indicador, notice: 'Indicador was successfully updated.' }
				format.json { head :ok }
			else
				format.html { render action: 'edit' }
				format.json { render json: @indicador.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@indicador = Indicador.find(params[:id])
		@indicador.destroy

		respond_to do |format|
			format.html { redirect_to indicadors_url }
			format.json { head :no_content }
		end
	end
	
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'indicador'
	end
	
end

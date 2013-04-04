class IndicadorProjetosController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	def index
		@indicador_projetos = IndicadorProjeto.all
	end

	def show
		@indicador_projeto = IndicadorProjeto.find(params[:id])
		if @indicador_projeto.indicador.tipo == 'data'
	    @indicador_projeto.valor = @indicador_projeto.valor.split('-')[2] + '/' + @indicador_projeto.valor.split('-')[1]+ '/' + @indicador_projeto.valor.split('-')[0] 
    end
	end
  
	def new
		@indicador_projeto = IndicadorProjeto.new
	end

	def edit
		@indicador_projeto = IndicadorProjeto.find(params[:id])
	end

	def create
	  @indicador_projeto = IndicadorProjeto.new(params[:indicador_projeto])
	  
	  if @indicador_projeto.indicador.tipo == 'data'
	    @indicador_projeto.valor = @indicador_projeto.valor.split('/')[2] + '-' + @indicador_projeto.valor.split('/')[1]+ '-' + @indicador_projeto.valor.split('/')[0] 
    end

		respond_to do |format|
			if @indicador_projeto.save
				format.html { redirect_to @indicador_projeto, notice: 'Sucesso!' }
				format.json { render json: @indicador_projeto, status: :created, location: @indicador_projeto }
			else
				format.html { render action: "new" }
				format.json { render json: @indicador_projeto.errors, status: :unprocessable_entity }
			end
		end
	end
	
	def createAll
	  @projetos = Projeto.all
	  
    respond_to do |format|
      @projetos.each do |projeto|
        if params[projeto.nome].size > 0
          @indicador_projeto = IndicadorProjeto.new()
          @indicador_projeto.valor = params[projeto.nome]
          @indicador_projeto.projeto_id = projeto.id
          @indicador_projeto.indicador_id = params['hddIdIndicador']
          if @indicador_projeto.indicador.tipo == 'data'
      	    @indicador_projeto.valor = @indicador_projeto.valor.split('/')[2] + '-' + @indicador_projeto.valor.split('/')[1]+ '-' + @indicador_projeto.valor.split('/')[0] 
          end
          @indicador_projeto.save
        end
		  end
		  @indicador = Indicador.find(params['hddIdIndicador'])
		  format.html { redirect_to @indicador, notice: 'Sucesso!' }
			format.json { render json: @indicador, status: :created, location: @indicador }
		end
	end

	def createAllIndicadores
	  @indicadors = Indicador.all
	  
    respond_to do |format|
      @indicadors.each do |indicador|
        if params[indicador.nome].size > 0
          @indicador_projeto = IndicadorProjeto.new()
          @indicador_projeto.valor = params[indicador.nome]
          @indicador_projeto.projeto_id = params['hddIdProjeto']
          @indicador_projeto.indicador_id = indicador.id
          if @indicador_projeto.indicador.tipo == 'data'
      	    @indicador_projeto.valor = @indicador_projeto.valor.split('/')[2] + '-' + @indicador_projeto.valor.split('/')[1]+ '-' + @indicador_projeto.valor.split('/')[0] 
          end
          @indicador_projeto.save
        end
		  end
		  @projeto = Projeto.find(params['hddIdProjeto'])
		  format.html { redirect_to @projeto, notice: 'Sucesso!' }
			format.json { render json: @projeto, status: :created, location: @projeto }
		end
	end


	def update
		@indicador_projeto = IndicadorProjeto.find(params[:id])
		
		if @indicador_projeto.indicador.tipo == 'data'
	    @indicador_projeto.valor = @indicador_projeto.valor.split('/')[2] + '-' + @indicador_projeto.valor.split('/')[1]+ '-' + @indicador_projeto.valor.split('/')[0] 
    end

		respond_to do |format|
			if @indicador_projeto.update_attributes(params[:indicador_projeto])
				format.html { redirect_to @indicador_projeto, notice: 'IndicadorProjeto was successfully updated.' }
				format.json { head :ok }
			else
				format.html { render action: 'edit' }
				format.json { render json: @indicador_projeto.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@indicador_projeto = IndicadorProjeto.find(params[:id])
		@indicador_projeto.destroy

		respond_to do |format|
			format.html { redirect_to indicador_projetos_url }
			format.json { head :no_content }
		end
	end
	
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'indicador_projeto'
	end
	
end

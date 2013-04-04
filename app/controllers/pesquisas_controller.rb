class PesquisasController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	def index
    @pesquisa = Pesquisa.new
    @pesquisas = Pesquisa.all
    @indicadores = Indicador.joins(:pesquisas)
    @projetos =	Projeto.all

    @pesquisas.each do |pesquisa|
      @projetos.delete_if do |projeto|        
        
        indicador_projeto = projeto.indicador_projetos.find_by_indicador_id(pesquisa.indicador.id)

        next unless indicador_projeto
        
        valor_indicador_projeto = indicador_projeto.valor
        
        valor_indicador_projeto = pesquisa.indicador.data? ? valor_indicador_projeto.to_date : valor_indicador_projeto.to_f
        valor_filtrado = pesquisa.indicador.data? ? pesquisa.valor.to_date : pesquisa.valor.to_f
        
        puts "\n\n\n\n"
        puts "valor_indicador_projeto: #{valor_indicador_projeto}"
        puts "valor_filtrado: #{valor_filtrado}"
        
        case pesquisa.operador.to_i
        when 1
          if valor_indicador_projeto == valor_filtrado
            puts "operador 1, nao exluir"
            next
          else
            puts "operador 1, excluir!"
            return true
          end
        when 2
          if valor_indicador_projeto > valor_filtrado
            puts "operador 2, nao exluir"
            next
          else
            puts "operador 2, excluir!"
            return true
          end
          
        when 3
          if valor_indicador_projeto < valor_filtrado
            puts "operador 3, nao exluir"
            next
          else
            puts "operador 3, excluir!"
            return true
          end
          
        end
      end
    end
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

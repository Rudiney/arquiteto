class PacotesController < ApplicationController
	before_filter :deve_escolher_um_produto
	before_filter :escolhe_item_menu
	
	def index
		@pacotes = @produto_escolhido.pacotes.all
	end

	def show
		@pacote = Pacote.find(params[:id])
	end

	def new
		@pacote = Pacote.new
	end

	def edit
		@pacote = Pacote.find(params[:id])
	end

	def create
		@pacote = Pacote.new(params[:pacote])
		@pacote.produto = @produto_escolhido

		respond_to do |format|
			if @pacote.save
				format.html { redirect_to @pacote, notice: 'Sucesso!' }
				format.json { render json: @pacote, status: :created, location: @pacote }
			else
				format.html { render action: "new" }
				format.json { render json: @pacote.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@pacote = Pacote.find(params[:id])

		respond_to do |format|
			if @pacote.update_attributes(params[:pacote])
				format.html { redirect_to @pacote, notice: 'Sucesso!' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @pacote.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@pacote = Pacote.find(params[:id])
		@pacote.destroy

		respond_to do |format|
			format.html { redirect_to pacotes_url }
			format.json { head :no_content }
		end
	end
	
	private 
	
	def escolhe_item_menu
		@menu_ativo = 'pacotes'
	end
	
end

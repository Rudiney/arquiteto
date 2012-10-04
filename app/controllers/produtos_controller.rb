class ProdutosController < ApplicationController

	skip_before_filter :deve_escolher_um_produto

	before_filter :busca_produto_sessao
	before_filter :escolhe_item_menu

	# GET /produtos
	# GET /produtos.json
	def index
		@produtos = Produto.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @produtos }
		end
	end

	# GET /produtos/1
	# GET /produtos/1.json
	def show
		@produto = Produto.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @produto }
		end
	end

	# GET /produtos/new
	# GET /produtos/new.json
	def new
		@produto = Produto.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @produto }
		end
	end

	# GET /produtos/1/edit
	def edit
		@produto = Produto.find(params[:id])
	end

	# POST /produtos
	# POST /produtos.json
	def create
		@produto = Produto.new(params[:produto])

		respond_to do |format|
			if @produto.save
				format.html { redirect_to @produto, notice: 'Produto was successfully created.' }
				format.json { render json: @produto, status: :created, location: @produto }
			else
				format.html { render action: "new" }
				format.json { render json: @produto.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /produtos/1
	# PUT /produtos/1.json
	def update
		@produto = Produto.find(params[:id])

		respond_to do |format|
			if @produto.update_attributes(params[:produto])
				format.html { redirect_to @produto, notice: 'Produto was successfully updated.' }
				format.json { head :ok }
			else
				format.html { render action: "edit" }
				format.json { render json: @produto.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /produtos/1
	# DELETE /produtos/1.json
	def destroy
		@produto = Produto.find(params[:id])
		@produto.destroy

		respond_to do |format|
			format.html { redirect_to produtos_url }
			format.json { head :ok }
		end
	end

	private

	# este controller em específico não é validado se prcisa de um produto selecionado
	# aqui a variavel é só carregada se tiver
	def busca_produto_sessao
		@produto_escolhido = Produto.find_by_id(session[:produto_id])
	end
	
	def escolhe_item_menu
		@menu_ativo = 'produtos'
	end
end

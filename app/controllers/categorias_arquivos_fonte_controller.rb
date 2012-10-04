class CategoriasArquivosFonteController < ApplicationController
	
	before_filter :escolhe_item_menu

	def index
		@caregorias_arquivos_fonte = @produto_escolhido.categorias_arquivos_fonte
	end
	
	def show 
		@categoria_arquivo_fonte = CategoriaArquivoFonte.do_produto(@produto_escolhido).find(params[:id])
	end
	
	def new
		@categoria_arquivo_fonte = CategoriaArquivoFonte.do_produto(@produto_escolhido).new
	end
	
	def create
		@categoria_arquivo_fonte = CategoriaArquivoFonte.new(params[:categoria_arquivo_fonte])
		@categoria_arquivo_fonte.produto = @produto_escolhido
		
		if @categoria_arquivo_fonte.save
			redirect_to @categoria_arquivo_fonte, notice: 'Sucesso!'
		else
			render action: 'new'
		end
	end
	
	def edit
		@categoria_arquivo_fonte = CategoriaArquivoFonte.do_produto(@produto_escolhido).find(params[:id])
	end
	
	def update
		@categoria_arquivo_fonte = CategoriaArquivoFonte.do_produto(@produto_escolhido).find(params[:id])
		
		if @categoria_arquivo_fonte.update_attributes(params[:categoria_arquivo_fonte])
			redirect_to @categoria_arquivo_fonte, notice: 'Sucesso!'
		else
			render action: 'edit'
		end
	end
	
	def destroy
		@categoria_arquivo_fonte = CategoriaArquivoFonte.do_produto(@produto_escolhido).find(params[:id])
		@categoria_arquivo_fonte.destroy
		redirect_to controller: :categorias_arquivos_fonte
	end



	private 
	
	def escolhe_item_menu
		@menu_ativo = 'categorias_arquivos_fonte'
	end
	
end
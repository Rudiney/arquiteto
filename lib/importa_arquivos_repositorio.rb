# encoding: UTF-8

class ImportaArquivosRepositorio

	attr_reader :arquivos_importados, :log_xml, :log
	
	def initialize(params={})
		raise 'um repositorio é necessário em :repositorio' unless params[:repositorio] && params[:repositorio].is_a?(Repositorio)
		@repositorio = params[:repositorio]
		@log_xml = params[:log_xml] || @repositorio.log_xml
		@arquivos_importados = []
	end
	
	
	def importa!
		ArquivoFonte.transaction do
			@log = SVN::Log.do_xml(@log_xml)
		
			@log.commits.each do |commit|
				
				@repositorio.ultima_revisao_importada = commit.revisao
				
				commit.arquivos.each do |arquivo_svn|
					
					next unless arquivo = importa_arquivo_svn(arquivo_svn)
					
					relaciona_o_arquivo_a_tarefa(commit.tarefa,arquivo) if commit.tarefa
					
				end
			end
			
			@repositorio.save!
		end
	end
	
	private
	
	# Importa um arquivo do SVN, criando o arquivo se ele ainda não existe no produto.
	# 
	# retorna o arquivo se importou com sucesso, e false se ocorreu qualquer erro ao importar
	# o arquivo
	def importa_arquivo_svn(arquivo_svn)
		ja_existe = ArquivoFonte.where(
			produto_id: @repositorio.produto.id, 
			caminho_completo: arquivo_svn.caminho_completo).first
		
		return ja_existe if ja_existe

		arquivo = ArquivoFonte.new(
			caminho_completo: arquivo_svn.caminho_completo,
			produto: @repositorio.produto
		)
		
		if arquivo.save
			@arquivos_importados << arquivo 
			return arquivo
		end
		
		return false
	end

	# relaciona o arquivo a uma tarefa caso este arquivo ainda não pertenca a tarefa.
	def relaciona_o_arquivo_a_tarefa(tarefa,arquivo)
		return if tarefa.arquivos_fonte.include?(arquivo)
		tarefa.arquivos_fonte << arquivo
	end
end
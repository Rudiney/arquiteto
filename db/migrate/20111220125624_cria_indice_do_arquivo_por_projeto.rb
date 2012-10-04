class CriaIndiceDoArquivoPorProjeto < ActiveRecord::Migration
	def up
		remove_index(:arquivos_fonte, :caminho_completo)
		add_index(:arquivos_fonte, [:projeto_id, :caminho_completo], unique:true)
	end

	def down
		add_index(:arquivos_fonte, :caminho_completo, unique:true)
		remove_index(:arquivos_fonte, [:projeto_id, :caminho_completo])
	end
end

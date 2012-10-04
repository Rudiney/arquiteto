class CriaTarefasArquivosFonte < ActiveRecord::Migration
	def change
		create_table :tarefas_arquivos_fonte do |t|
		  t.integer :tarefa_id,        :null => false
		  t.integer :arquivo_fonte_id, :null => false
		  t.timestamps
		end
		
		add_foreign_key(:tarefas_arquivos_fonte,:tarefas, dependent: :delete)
		add_foreign_key(:tarefas_arquivos_fonte,:arquivos_fonte, dependent: :delete)
		
		add_index(:tarefas_arquivos_fonte, [:tarefa_id,:arquivo_fonte_id], unique: true)
	end
end
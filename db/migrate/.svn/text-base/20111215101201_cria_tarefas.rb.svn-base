class CriaTarefas < ActiveRecord::Migration
	def change
		create_table :tarefas do |t|
		  t.integer :historia_id,  :null => false
		  t.string  :descricao,    :null => false
		  t.integer :segundos_estimados
		  t.integer :segundos_reais
		  t.timestamps
		end
		
		add_foreign_key(:tarefas,:historias, dependent: :delete)
	end
end

class CriaIndicadoresDoProjeto < ActiveRecord::Migration
  def up
		create_table :indicador_projetos do |t|
			t.integer	:projeto_id,            :null => false
			t.integer :indicador_id,          :null => false
			t.string  :valor
			t.timestamps
		end
	end


   def down
     remove_table :indicador_projeto
   end
end

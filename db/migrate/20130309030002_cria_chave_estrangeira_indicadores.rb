class CriaChaveEstrangeiraIndicadores < ActiveRecord::Migration
  def up
    add_foreign_key(:indicador_projetos, :projetos, :column => :projeto_id)
		add_foreign_key(:indicador_projetos, :indicadors, :column => :indicador_id)
  end

  def down
    remove_foreign_key(:indicador_projetos, :column => :projeto_id)
		remove_foreign_key(:indicador_projetos, :column => :indicador_id)
  end
end

class AlteraTabelaHistoriasTamanho < ActiveRecord::Migration
	def up
		remove_column(:historias, :tamanho)
		add_column(:historias, :complexidade_negocio, :integer, default: 0, null: false)
		add_column(:historias, :complexidade_interface, :integer, default: 0, null: false)
		add_column(:historias, :esforco, :integer, default: 0, null: false)
		add_column(:historias, :risco, :integer, default: 0, null: false)
	end
	
	def down
		add_column(:historias, :tamanho, :integer, default:0)
		remove_column(:historias, :complexidade_negocio)
		remove_column(:historias, :complexidade_interface)
		remove_column(:historias, :esforco)
		remove_column(:historias, :risco)
	end
end

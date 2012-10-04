class CriaDescricaoProduto < ActiveRecord::Migration
	def change
		add_column(:produtos, :descricao, :text)
	end
end

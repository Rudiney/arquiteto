class AdicionaUrlBaseWikiNosProjetos < ActiveRecord::Migration
	def change
		add_column :projetos, :url_base_wiki, :string
	end
end
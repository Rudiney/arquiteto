class Produto < ActiveRecord::Base
	
	attr_accessible :nome
	
	validates :nome, :presence => true
	
	has_many :funcionalidades, :dependent => :destroy
	has_many :historias,       :dependent => :destroy 
	has_one  :repositorio,		:dependent => :destroy
	has_many :pacotes,			:dependent => :destroy
	has_many :arquivos_fonte,  :class_name => 'ArquivoFonte',  :dependent => :destroy
	has_many :categorias_arquivos_fonte, :class_name => "CategoriaArquivoFonte", :dependent => :destroy
end

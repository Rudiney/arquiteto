# Classe para um arquivo alterado em um commit do SVN
module SVN
	class Arquivo
		
		attr_accessor :tipo, :acao, :caminho_completo, :commit
		attr_reader :nome, :diretorio

		# Cria um novo arquivo com utilizando como base o hash gerado a partir 
		# da conversão do xml. Criado para quando os arquivos são criados pelo commit,
		# onde o xml já foi convertido para hash.
		# O hash tem as chaves kind, action e __content__
		def self.do_hash_xml(hash)
			arquivo = SVN::Arquivo.new()
			
			arquivo.tipo             = hash['kind']
			arquivo.acao             = hash['action']
			arquivo.caminho_completo = hash['__content__']
			
			return arquivo
		end
		
		# Cria um novo arquivo do svn com base no xml gerado pelo log.
		# o pedaço do xml é o seguinte:
		#  <path kind="file" action="M">/caminho/completo/para/meu/arquivo.txt</path>
		def self.do_xml(xml_str)
			xml = ActiveSupport::XmlMini.parse(xml_str)
			
			raise 'A raiz do xml deve ser a tag PATH' unless xml['path']
			
			return SVN::Arquivo.do_hash_xml(xml['path'])			
		end
		
		def caminho_completo=(caminho_completo)
			
			@caminho_completo = caminho_completo
			
			@nome      = @caminho_completo.split('/').last
			@diretorio = @caminho_completo.gsub("/#{@nome}",'')
		end
		
	end
end
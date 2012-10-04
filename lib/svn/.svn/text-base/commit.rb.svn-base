module SVN
	class Commit
		REGEXP_TAREFA = /^{\s?t:\s?(?<historia>\w+)\.(?<tarefa>\w+)/
		REGEXP_DURACAO = /\sd:\s?(?<tempo>\w+:?\w*)/
		
		attr_accessor :revisao, :autor, :mensagem, :hora, :arquivos, :log
		
		def self.do_hash_xml(hash)
			commit = SVN::Commit.new()
			
			commit.revisao  = hash['revision']
			commit.autor    = hash['author']['__content__']
			commit.mensagem = hash['msg']['__content__']
			commit.hora     = Time.parse(hash['date']['__content__'])
			
			commit.arquivos = []
			
			arquivos = hash['paths']['path']
			return commit unless arquivos
			
			# o parse do xml transforma em um hash quando só tem um item, e um vetor 
			# quando tem vários
			case 
			when arquivos.is_a?(Hash)
				commit.novo_arquivo_do_hash(arquivos)
			when arquivos.is_a?(Array)
				arquivos.each do |hash_arquivo|
					commit.novo_arquivo_do_hash(hash_arquivo)
				end
			end
			
			return commit
		end
		
		def self.do_xml(xml_str)
			xml = ActiveSupport::XmlMini.parse(xml_str)
			
			raise 'A raiz do xml deve ser a tag logentry' unless xml['logentry']
			
			return SVN::Commit.do_hash_xml(xml['logentry'])
		end
		
		def novo_arquivo_do_hash(hash)
			self.arquivos ||= []
			arquivo = SVN::Arquivo.do_hash_xml(hash)
			arquivo.commit = self
			self.arquivos << arquivo		
		end

		#sempre que setar uma nova mensagem no commit, a tarefa e a duração do commit podem mudar
		def mensagem=(msg)
			@tarefa   = nil
			@duracao  = nil
			@mensagem = msg
		end
		
		def tarefa
			@tarefa ||= busca_tarefa!
		end
		
		def duracao
			@duracao ||= busca_duracao_da_tarefa!
		end
		
		private
		
		# Busca a tarefa de um commit através do seu identificador na mensagem do commit.
		# sintaxe = {t:34.65} onde 34.65 é o identificador da tarefa
		def busca_tarefa!
			return if self.mensagem.blank?
			
			return unless regexp_tarefa = self.mensagem.match(REGEXP_TAREFA)
			
			return @tarefa if @tarefa = Tarefa.find_by_id(regexp_tarefa[:tarefa])
		end
		
		# no commit é possível informar quanto tempo levou para codificar uma tarefa
		# sintaxe: d: 4:32 onde 4:32 é o tempo de duração da tarefa.
		# o commit tem duração somente se tiver uma tarefa
		def busca_duracao_da_tarefa!
			return unless self.tarefa

			return unless regexp_duracao = self.mensagem.match(REGEXP_DURACAO)

			duracao = regexp_duracao[:tempo].em_segundos

			return @duracao = duracao.zero? ? nil : duracao
		end
		
	end
end
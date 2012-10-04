module SVN
	class Log
		attr_accessor :commits
		
		def self.do_xml(xml_str)
			xml = ActiveSupport::XmlMini.parse(xml_str)
			
			raise 'A raiz do xml deve ser a tag log' unless xml['log']
			
			log     = SVN::Log.new()
			commits = xml['log']['logentry']
			
			return log unless commits

			case 
			when commits.is_a?(Hash)
				log.novo_commit_do_hash(commits)
			when commits.is_a?(Array)
				commits.each do |commit|
					log.novo_commit_do_hash(commit)
				end
			end
			
			return log
		end
		
		def novo_commit_do_hash(hash)
			self.commits ||= []
			commit = SVN::Commit.do_hash_xml(hash)
			commit.log = self
			self.commits << commit
		end
	end
end

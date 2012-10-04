class HistoriaAnexo < ActiveRecord::Base
	
	belongs_to :historia
	
	has_attached_file :arquivo
	
	validates :historia_id, :presence => true
end
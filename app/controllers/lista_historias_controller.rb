# encoding: UTF-8

class ListaHistoriasController < BacklogController
	before_filter :deve_escolher_um_produto
	
	def em_pdf
		
		html = render_to_string(partial: 'em_pdf')
		pdf = WickedPdf.new.pdf_from_string(html)
		
		save_path = Rails.root.join('public','filename.pdf')
		File.open(save_path, 'wb') do |file|
		  file << pdf
		end
	end
end
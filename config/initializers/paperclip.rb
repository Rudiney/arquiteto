Paperclip::Attachment.default_options.update({
	:path => ":rails_root/public/anexos/:class/:id_:basename.:extension",
	:url =>"/anexos/:class/:id_:basename.:extension"
})
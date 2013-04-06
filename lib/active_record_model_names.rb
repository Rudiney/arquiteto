# encoding: UTF-8

module ActiveRecordModelNames
	module ClassMethods
		def model_names(reload = false)
			
			@model_names = nil if reload
			
			@model_names ||= {
				singular:       I18n.t("activerecord.model_names.#{self.name.underscore}.singular",       default: self.name.underscore),
				plural:         I18n.t("activerecord.model_names.#{self.name.underscore}.plural",         default: self.name.underscore.pluralize),
				human_singular: I18n.t("activerecord.model_names.#{self.name.underscore}.human_singular", default: self.model_name.human),
				human_plural:   I18n.t("activerecord.model_names.#{self.name.underscore}.human_plural",   default: self.name.underscore.pluralize.humanize)
			}
		end
	end

	def self.included(base)
		base.extend(ClassMethods)
	end
end

class ActiveRecord::Base
	include ActiveRecordModelNames
end
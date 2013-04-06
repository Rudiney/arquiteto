# encoding: UTF-8

module ActiveRecordBaseAccessibleAttributes
	def accessible_attributes
		self.attributes.slice(*self.class.accessible_attributes.to_a)
	end
end

class ActiveRecord::Base
	include ActiveRecordBaseAccessibleAttributes
end
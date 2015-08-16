class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


	def r(what=nil)
		raise debug what if respond_to?(:debug)
		raise what.kind_of?(String) ? what : what.to_json
	end

end

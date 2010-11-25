class CouplesController < ApplicationController
	before_filter :authorized?
	def authorized?
		return true if not current_user.nil?
		false
	end
	def show
		@couple = Couple.find(params[:id])
		@other = current_user.significant_other
	end
end

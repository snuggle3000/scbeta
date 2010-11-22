class CouplesController < ApplicationController
	def show
		@couple = Couple.find(params[:id])
	end
end

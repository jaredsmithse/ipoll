class VisitorsController < ApplicationController
	def index
		@room = Room.new
		@room.name = ''
	end
end

class ListingsController < ApplicationController
  def new
  	render template: "listings/new"
  end

  def create
  	listing = Listing.new
  	listing.name = params[:listing][:name]
  	listing.description = params[:listing][:description]
  	listing.address = params[:listing][:address]
  	listing.price = params[:listing][:price]
		listing.user_id = current_user.id
		listing.save
		redirect_to '/listings'
	end

	def index
		@listings = Listing.all
		render template: "listings/index"
	end
end

class ListingsController < ApplicationController
  def new
  	@listing = Listing.new
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

	def show
		@listing = Listing.find(params[:id])
		@user = @listing.user

		render template: "listings/show"
	end

	def edit
		@listing = Listing.find(params[:id])
		render template: "listings/edit"
	end

	def update
		# params.require(:listing).permit(:name, :description, :address, :price)
		@listing = Listing.find(params[:id])
		@listing.name = params[:listing][:name]
  	@listing.description = params[:listing][:description]
  	@listing.address = params[:listing][:address]
  	@listing.price = params[:listing][:price]
		@listing.save
		redirect_to "/listings/#{@listing.id}"
	end

	def destroy
		Listing.destroy(params[:id])
		redirect_to "/listings"
	end
end

class ListingsController < ApplicationController
  def new
  	@listing = Listing.new
  	render template: "listings/new"
  end

  def create
  	# @listing = current_user.listing.new(listing_params)
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
		@user = current_user
		if @user.role == "landlord"
			@listings = Listing.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 10)
		else 
			@listings = Listing.all.paginate(:page => params[:page], :per_page => 10).order('name DESC')
		end
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
		@listing = Listing.find(params[:id])
		@listing.name = params[:listing][:name]
  	@listing.address = params[:listing][:address]
  	@listing.price = params[:listing][:price]
  	@listing.description = params[:listing][:description]
		@listing.save
		redirect_to "/listings/#{@listing.id}"
	end

	def destroy
		Listing.destroy(params[:id])
		redirect_to "/listings"
	end

	private

		def listing_params
			params.require(:listing).permit(:name, :description, :address, :price)
		end
end

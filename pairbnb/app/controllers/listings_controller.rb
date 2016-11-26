class ListingsController < ApplicationController
  def new
  	@listing = Listing.new
  	render template: "listings/new"
  end

  def create
  	@listing = current_user.listings.new(listing_params)
  	if @listing.save
			redirect_to '/listings'
    else
        render 'new'
    end
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
		if @listing.update(listing_params)
			redirect_to "/listings/#{@listing.id}", notice: "Success!"
		else 
      render 'edit'
    end
	end

	def destroy
		Listing.destroy(params[:id])
		redirect_to "/listings"
	end

	private

	def listing_params
		params.require(:listing).permit(:name, :description, :address, :price, {photos: []})
	end
end

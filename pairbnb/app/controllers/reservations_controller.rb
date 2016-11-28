class ReservationsController < ApplicationController
	
	def create
		listing = Listing.find(params[:listing_id])
		reservation = listing.reservations.new(reservation_params)
		reservation.calculate_price	
		if reservation.save
			redirect_to listing, notice: "Reservation successful!"
		else
			redirect_to listing, notice: "Reservation failed!"

	end

	private

	def reservation_params
		params.require(:reservation).permit(:check_in, :check_out, :user_id, :listing_id)
	end

	
end

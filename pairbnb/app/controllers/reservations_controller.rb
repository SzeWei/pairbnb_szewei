class ReservationsController < ApplicationController
	
	def create
		# @user = User.find(params[:reservation][:id])
		# listing = Listing.find(params[:listing_id])
		# reservation = listing.reservations.new(reservation_params)
		# reservation.calculate_price	
		# if reservation.save
		# 	# ReservationMailer.booking_email(@user.email).deliver_later
		# 	redirect_to listing, notice: "Reservation successful!"
		# else
		# 	redirect_to listing, notice: "Reservation failed!"
		# end
		listing = Listing.find(params[:listing_id])
    reservation = listing.reservations.new(reservation_params)
    reservation.calculate_price
    # host = reservation.listing
    # @user = reservation.user
    # if reservation.save
    # 	ReservationMailer.booking_email(@user, host, reservation.id).deliver_later
   	# 	ReservationJob.perform_later(@user, host, reservation.id)
      redirect_to new_reservation_payment_path(reservation.id)
    # else
    #   redirect_to listing, notice: "Reservation failed!"
    # end
	end

	def show
		@reservation = Reservation.find(params[:id])
		@user = @reservation.user
		@listing = @reservation.listing
		render template: "reservations/show"
	end

	private

	def reservation_params
		params.require(:reservation).permit(:check_in, :check_out, :user_id, :listing_id)
	end

	
end

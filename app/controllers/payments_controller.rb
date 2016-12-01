class PaymentsController < ApplicationController
	def new
		# byebug
		@reservation = Reservation.find(params[:reservation_id])
		gon.client_token = generate_client_token
	end

	def create
		@reservation = Reservation.find(params[:reservation_id])
		listing = @reservation.listing_id
    @result = Braintree::Transaction.sale(
	    amount: @reservation.total_price,
	    payment_method_nonce: params[:payment_method_nonce])
    @user = @reservation.user
   	host = @reservation.listing
    if @result.success?
      redirect_to listing_reservation_path(listing,@reservation.id), notice: "Congratulations! Your payment is successful!"
      @reservation.save
      ReservationMailer.booking_email(@user, host, @reservation.id).deliver_later
    else
      flash[:alert] = "Something went wrong while processing your payment. Please book again!"
      redirect_to listing_path(listing)
    end
  end



	private
	def generate_client_token
	  Braintree::ClientToken.generate
	end

end
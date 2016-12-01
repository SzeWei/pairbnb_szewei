class ReservationMailer < ApplicationMailer
	# default from: 'khooszewei92@gmail.com'
 
  def booking_email(customer, host, reservation_id)
    @customer = customer
    @host = host
    @reservation = reservation_id
    @url  = "https://szewei-pairbnb.herokuapp.com/listings/#{@host.user.id}/reservations/#{@reservation}"
    mail(to: @host.user.email, subject: 'Your reservation is confirmed!')
  end
end

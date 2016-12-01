# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
def booking_email(customer)
	customer = User.last
	ReservationMailer.booking_email(customer)
end
end

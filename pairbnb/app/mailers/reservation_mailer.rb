class ReservationMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def booking_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
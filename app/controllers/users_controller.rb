class UsersController < Clearance::UsersController
  # if respond_to?(:before_action)
  #   before_action :redirect_signed_in_users, only: [:create, :new]
  #   skip_before_action :require_login, only: [:create, :new], raise: false
  #   skip_before_action :authorize, only: [:create, :new], raise: false
  # else
  #   before_filter :redirect_signed_in_users, only: [:create, :new]
  #   skip_before_filter :require_login, only: [:create, :new], raise: false
  #   skip_before_filter :authorize, only: [:create, :new], raise: false
  # end

  def new
    @user = User.new
    render template: "users/new"
  end

  def create
    @user = User.new(user_params)

    if @user.save
       sign_in @user
      # UserMailer.welcome_email(@user).deliver_later
      render template: "users/edit"
    end
  end

  #   respond_to do |format|
  #     if @user.save
  #       sign_in @user
  #       # Tell the UserMailer to send a welcome email after save
  #      UserMailer.welcome_email(@user).deliver_later
 
  #       format.html { redirect_to(@user, notice: 'User was successfully created.') }
  #       format.json { render json: @user, status: :created, location: @user }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def show
    @user = User.find(params[:id])
    render template: "users/show"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to "/users/#{@user.id}", notice: "Success!"
    else 
      render 'edit'
    end
  end

  private

  def avoid_sign_in
    warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " +
      "deprecated. Use `redirect_signed_in_users` instead. " +
      "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" +
      " or `skip_before_action :avoid_sign_in` as well"
    redirect_signed_in_users
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to Clearance.configuration.redirect_url
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :avatar)
  end
end


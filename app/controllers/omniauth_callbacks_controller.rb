class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(user_params)
    #byebug
    if user.persisted?
      flash[:notice] = "Signed In!"
      sign_in_and_redirect user
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_session_path
    end
  end


private 

  def user_params
     p = ActionController::Parameters.new(request.env["omniauth.auth"])
     p.permit(:provider, :uid, :info )
  end

end
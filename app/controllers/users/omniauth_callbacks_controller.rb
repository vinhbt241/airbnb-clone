class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    process_oauth("Google")
  end

  def facebook
    process_oauth("Facebook")
  end

  private 

  def process_oauth(provider)
    @user = User.from_omniauth(auth)

    if @user.persisted? 
      sign_out_all_scopes 
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: provider
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: provider, reason: "#{auth.info.email} is not authorized"
      session["devise.#{provider.downcase}_data"] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url
    end
  end

  def auth 
    @auth ||= request.env['omniauth.auth']
  end
end

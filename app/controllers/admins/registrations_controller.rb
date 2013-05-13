class Admins::RegistrationsController < Devise::RegistrationsController
  def create
    if params[:admin][:authorization_code] == "aimac12345"
      super
    else
      build_resource
      clean_up_passwords(resource)
      # resource.errors.add(authorization_code, 'There was an error with the authorization code below. Please re-enter the authorization code.')
      flash.now[:alert] = "There was an error with the authorization code below. Please re-enter the authorization code."
      render :new
    end
  end
end
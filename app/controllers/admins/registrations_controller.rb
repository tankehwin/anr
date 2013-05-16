class Admins::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    if params[:admin][:authorization_code] == "4NR@sentulasia.com"
      admin = Admin.find_by_email resource.email if resource.email
      if admin
        admin.active = true
        admin.save
        sign_in resource_name, resource, :bypass => true
        respond_with resource, :location => after_update_path_for(resource)
      else
        super
      end
    else
      build_resource
      clean_up_passwords(resource)
      # resource.errors.add(authorization_code, 'There was an error with the authorization code below. Please re-enter the authorization code.')
      flash.now[:alert] = "There was an error with the authorization code below. Please re-enter the authorization code."
      render :new
    end
  end

  # DELETE /resource
  def destroy
    resource.active = false
    resource.save
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end
end
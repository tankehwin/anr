class Admins::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    if params[:admin][:authorization_code] == "4NR@sentulasia.com"
      admin = Admin.find_by_email params[:admin][:email] if params[:admin][:email] and not params[:admin][:email].blank?
      if admin
        admin.active = true
        admin.save
        sign_in :admin, admin, :bypass => true
        respond_with admin, :location => after_update_path_for(admin)
      else
        super
      end
    else
      build_resource(params[:admin])
      clean_up_passwords(resource)
      resource.errors.add :authorization_code, "incorrect. Please re-enter the authorization code."
      respond_with resource
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
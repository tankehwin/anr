class Organizers::RegistrationsController < Devise::RegistrationsController
  def create
    if verify_recaptcha(:model => resource, :timeout => 10, :message => "Are you human? The code you entered is not valid.")
      organizer = Organizer.find_by_email resource.email if resource.email
      if organizer
        organizer.active = true
        organizer.save
        sign_in resource_name, resource, :bypass => true
        respond_with resource, :location => after_update_path_for(resource)
      else
        super
      end
    else
      build_resource
      clean_up_passwords(resource)
      # resource.errors.add(authorization_code, 'Are you human? The code you entered is not valid.')
      flash[:error] = "Are you human? The code you entered is not valid."
      render_with_scope :new
    end
  end

  def destroy
    resource.active = false
    resource.save
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end
end
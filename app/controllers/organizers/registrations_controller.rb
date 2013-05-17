class Organizers::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    if verify_recaptcha(:model => Organizer.new(params[:organizer]), :timeout => 3) or Rails.env.development?
      organizer = Organizer.find_by_email params[:organizer][:email] if params[:organizer][:email] and not params[:organizer][:email].blank?
      if organizer
        organizer.active = true
        organizer.save
        sign_in :organizer, organizer, :bypass => true
        respond_with organizer, :location => after_update_path_for(organizer)
      else
        super
      end
    else
      build_resource(params[:organizer])
      clean_up_passwords(resource)
      resource.errors.add :authentication_code, "you entered is not valid. Are you human?"
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
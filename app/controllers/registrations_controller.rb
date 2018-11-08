class RegistrationsController < Devise::RegistrationsController

  protected

  # Redirect on profile edit
  def after_update_path_for(resource)
    profile_path(resource)
  end
end
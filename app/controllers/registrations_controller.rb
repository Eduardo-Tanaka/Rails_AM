# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  before_action :find_user, only: [:edit, :update]

  def new
    super
  end

  def create
    # add custom create logic here
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        Person.create(user_id: User.last.id)
        Address.create(person_id: User.last.id)
        Phone.create(person_id: User.last.id)
        Phone.create(person_id: User.last.id)
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        Person.create(user_id: User.last.id)
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update
    super
  end

  private

  def find_user
    @person = Person.find(current_user.id)
  end
end

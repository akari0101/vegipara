class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  #def new
    #super
  #end



  #def after_sign_in_path_for(resource)
    #customers_path(current_customers)
  #end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :kana_last_name, :kana_first_name, :post_code, :address, :phone_number])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email])
  end

  def after_sign_up_path_for(resource)
    root_path
  end

end


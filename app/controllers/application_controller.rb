class ApplicationController < ActionController::Base
  before_action :populate_dropdown, :initialize_session, :cart_access
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :cart

  def populate_dropdown
    categories = Category.includes(:subcategories).order("name ASC")
    @dropdown_categories = categories.collect { |c| [c.name, c.id] }
    @dropdown_categories.unshift(["All Categories", 0])
  end

  def cart
    Beer.find(session[:cart])
  end

  def initialize_session
    session[:cart] ||= {}
  end

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me address province_id]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def cart_access
    @cart_link = if current_user
                   cart_index_path
                 else
                   new_user_session_path
                 end
  end
end

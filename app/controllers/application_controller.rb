class ApplicationController < ActionController::Base
  before_action :populate_dropdown, :initialize_session
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
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

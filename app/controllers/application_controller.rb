class ApplicationController < ActionController::Base
  before_action :populate_dropdown

  def populate_dropdown
    categories = Category.includes(:subcategories).order("name ASC")
    @dropdown_categories = categories.collect { |c| [c.name, c.id] }
    @dropdown_categories.unshift(["All Categories", 0])
  end
end

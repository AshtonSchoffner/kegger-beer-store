class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  attr_writer :login

  def login
    @login || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login == conditions.delete(:login)
      where(conditions.to_h).where(["lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
end

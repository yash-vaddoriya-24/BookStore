class User < ApplicationRecord
  after_create_commit :assign_default_role
  rolify strict: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable

  private

  def assign_default_role
    Rails.logger.debug "Assigning default role to user: #{self.id}"
    return if self.roles.exists?(name: 'newuser')

    self.add_role(:newuser)
  end


end

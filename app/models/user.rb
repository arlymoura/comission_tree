class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :send_admin_mail
  # before_create :generated_password

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum kind: [:salesman, :manager]
  enum status: [:active, :inactive]

  has_many :comissions
  has_many :addresses
  has_many :product_quantities
  has_many :sales

  def send_admin_mail
    UserMailer.signup_confirmation(self).deliver
  end

  # def generated_password
  #   self.password = Devise.friendly_token.first(6)
  # end

end

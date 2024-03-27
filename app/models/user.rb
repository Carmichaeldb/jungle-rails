class User < ApplicationRecord
  before_save :normalize_email
  has_secure_password

  def self.authenticate_with_credentials (email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  private

  def normalize_email
    self.email = email.strip.downcase if email.present?
  end

end

class User < ApplicationRecord

  has_many :resources

  validates :email, :username, uniqueness: true
  validates :name, :username, :email, presence: true


  validate  :validate_password


  def password
    @password ||= BCrypt::Password.new(encrypted_password)
  end

  def password=(new_password)
    @plain_text_password = new_password
    @password = BCrypt::Password.create(new_password)
    self.encrypted_password = @password
  end

  def authenticate(password)
    self.password == password
  end

  def validate_password
    if @plain_text_password.nil?
      errors.add(:password, "is required")
    elsif @plain_text_password.length < 8
      errors.add(:password, "must be 8 characters or more")
    end
  end
end

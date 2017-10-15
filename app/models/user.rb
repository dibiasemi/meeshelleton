class User < ApplicationRecord

  #Here's where you would include associations

  validates :email, uniqueness: true
  validates :name, :username, :email, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  validate  :validate_password
  def password
  # Virtual attribute
    @password ||= BCrypt::Password.new(encrypted_password)
  end

  def password=(new_password)
#Store plain text password into an instance variable when it's live and in actual object memory
    @plain_text_password = new_password
    @password = BCrypt::Password.create(new_password)
    self.encrypted_password = @password
  end

  def authenticate(password)
    self.password == password
  end

# Empty strings as passwords can actually be hashed - therefore you can't just simply write a "validates :password, presence: true" because it will never NOT be true, the password will always have a value/get encrypted, instead you can validate the plain text password that is typed in, NOT what gets stored in the database.

# Need to write a custom validator for a password
# Presensce and length are good starts before you do fancy regex (characters, uppercase, etc.)

  def validate_password
    if @plain_text_password.nil?
      errors.add(:password, "is required")
    elsif @plain_text_password.length < 8
      errors.add(:password, "must be 8 characters or more")
    end
  end
end

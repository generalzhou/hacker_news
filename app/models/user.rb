class User < ActiveRecord::Base

  has_many :posts
  has_many :comments
  
  validates :name, :presence => true, :uniqueness => true
  validate :has_password

  include BCrypt

  def password
    @password ||= Password.new(self.password_hash)
  end
  
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.create(options={})
    @user = User.new(options)
    @user.password = options[:password]
    @user.save!
    @user
  end

  def has_password
    errors.add(:password, 'cannot be blank') if self.password == ''
  end

  def self.authenticate(params)
    @user = User.find_by_name(params[:name])
    (@user && @user.password == params[:password]) ? @user : false
  end

  def days_active
    Time.now.day - created_at.day
  end

end

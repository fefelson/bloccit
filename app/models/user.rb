class User < ActiveRecord::Base
  #enum helper has to be before validation for validation to work
  enum role: [:member, :admin]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_save -> { self.email = email.downcase }, if: -> { email.present? }

  validates :name, length: {minimum: 1, maximum: 100}, presence: true

  validates :password, presence: true, length: {minimum: 6}, if: "password_digest.nil?"
  validates :password, length: {minimum: 6}, allow_blank: true

  validates :role, presence: true,
    inclusion: { in: roles.keys , message: "%{value} is not a valid role" }

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false},
    length: { minimum: 3, maximum: 254}

  has_secure_password


  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def posts_comments?
    return self.posts.count > 0 || self.comments.count > 0
  end


end

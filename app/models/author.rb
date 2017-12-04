class Author < ApplicationRecord
  has_many :favorite_articles, class_name:  'Favorite',
                               foreign_key: 'author_id',
                               dependent: :destroy
  has_many :favorites, through: :favorite_articles,
                       source: :article

  has_many :active_follows, class_name:  'Follow',
                            foreign_key: 'follower_id',
                            dependent: :destroy

  has_many :passive_follows, class_name:  'Follow',
                             foreign_key: 'followed_id',
                             dependent: :destroy

  has_many :following, through: :active_follows,
                       source: :followed

  has_many :followers, through: :passive_follows,
                       source: :follower


  has_many :articles, dependent: :destroy

  attr_accessor :remember_token

  before_save { email.downcase! }

  validates :name,
            presence: true,
            length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password,
            presence: true,
            length: { minimum: 6 },
            allow_nil: true

  class << self

    # Returns the hash digest of the given string.
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end

  end

  # Remembers an author in the database for use in persistent sessions.
  def remember
    self.remember_token = Author.new_token
    update_attribute(:remember_digest, Author.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets an author.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Defines a feed.
  def feed
    following_ids = 'SELECT followed_id FROM follows
                     WHERE  follower_id = :author_id'
    Article.where("author_id IN (#{following_ids}) OR author_id = :author_id",
                  author_id: id)
  end

  # Follows an author.
  def follow(other_author)
    # following << other_author
    active_follows.create(followed_id: other_author.id)
  end

  # Unfollows an author.
  def unfollow(other_author)
    following.delete(other_author)
  end

  # Returns true if the current author is following the other user.
  def following?(other_author)
    following.include?(other_author)
  end



  # Favorite an article.
  def favorite(article)
    favorites << article
    # favorite_articles.create(article_id: article.id)
  end

  # Unfollows  an article.
  def unfavorite(article)
    favorites.delete(article)
  end

  # Returns true if the current author is favoriting an article.
  def favoring?(article)
    favorites.include?(article)
  end

end

class Article < ApplicationRecord
  has_many :favoriting_author, class_name:  'Favorite',
                               foreign_key: 'article_id',
                               dependent: :destroy
  has_many :favoraiters, through: :favoriting_author,
                         source: :author

  belongs_to :author

  default_scope -> { order(created_at: :desc) }

  mount_uploader :default_picture, PictureUploader

  validates :author_id, presence: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :content, presence: true, length: { minimum: 300 }
  validate  :picture_size

  def default_image_url
    ['default_article.jpg'].compact.join('_')
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if default_picture.size > 5.megabytes
      errors.add(:default_picture, 'should be less than 5MB')
    end
  end

end

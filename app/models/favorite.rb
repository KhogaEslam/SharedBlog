class Favorite < ApplicationRecord
  belongs_to :article
  belongs_to :author

  validates :article_id, presence: true
  validates :author_id, presence: true
end

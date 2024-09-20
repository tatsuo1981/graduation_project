class Board < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :goodmarks, dependent: :destroy

  mount_uploader :board_image, BoardImageUploader
   # ransack最新バージョン適用
  def self.ransackable_associations(auth_object = nil)
    ["goodmarks", "comments", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["board_image", "body", "created_at", "id", "title", "updated_at", "user_id"]
  end
end

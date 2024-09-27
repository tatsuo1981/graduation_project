class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :goodmarks, dependent: :destroy
  has_many :goodmark_boards, through: :goodmarks, source: :board
  has_many :shops, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_shops, through: :bookmarks, source: :shop

  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object&.user_id
  end

  def self.ransackable_attributes(auth_object = nil)
    ["first_name", "last_name", "email", "created_at", "role"] # 必要に応じて検索可能にしたい属性を追加
  end

  def self.ransackable_associations(auth_object = nil)
    ["boards", "bookmark_shops", "bookmarks", "comments", "goodmark_boards", "goodmarks", "shops"]
  end

  def bookmark(shop)
    bookmark_shops << shop
  end

  def unbookmark(shop)
    bookmark_shops.destroy(shop)
  end

  def bookmark?(shop)
    bookmark_shops.include?(shop)
  end

  def goodmark(board)
    goodmark_boards << board
  end

  def ungoodmark(board)
    goodmark_boards.destroy(board)
  end

  def goodmark?(board)
    goodmark_boards.include?(board)
  end
end

class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :goodmarks, dependent: :destroy
  has_many :goodmark_boards, through: :goodmarks, source: :board

  def own?(object)
    id == object&.user_id
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

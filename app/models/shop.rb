class Shop < ApplicationRecord
  mount_uploader :shop_image, ShopImageUploader

  # 必須項目のバリデーション
  validates :shop_name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # 住所のバリデーション（任意だが、形式をチェックする場合）
  validates :address, length: { maximum: 255 }

  # 電話番号のバリデーション（任意だが、形式をチェックする場合）
  validates :tel, format: { with: /\A0\d{1,4}-?\d{1,4}-?\d{4}\z/, message: "は正しい形式で入力してください（例: 03-1234-5678）" }, allow_blank: true

  # 営業時間のバリデーション
  validates :shop_hours, format: { 
  with: /\A(?:\d{1,2}:\d{2}\s?[-ー~〜]\s?\d{1,2}:\d{2}(?:,\s?|\s?&\s?|\s?と\s?)?)+\z/, 
  message: "は正しい形式で入力してください（例: 10:00 - 18:00、10:00 〜 18:00）" 
  }, allow_blank: true

  belongs_to :user
  has_many :bookmarks, dependent: :destroy
end

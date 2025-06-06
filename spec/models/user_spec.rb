# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      email: "test@example.com",
      password: "password",
      password_confirmation: "password",
      first_name: "たつお",
      last_name: "はらの"
    )
  end

  describe 'バリデーション' do
    it '有効なユーザーであること' do
      expect(user).to be_valid
    end

    it 'メールアドレスがなければ無効' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'パスワードが3文字未満なら無効' do
      user.password = 'ab'
      user.password_confirmation = 'ab'
      expect(user).not_to be_valid
    end

    it 'パスワード確認がパスワードと違う場合は無効' do
      user.password_confirmation = 'different'
      expect(user).not_to be_valid
    end

    it 'first_nameがなければ無効' do
      user.first_name = ''
      expect(user).not_to be_valid
    end

    it 'last_nameがなければ無効' do
      user.last_name = ''
      expect(user).not_to be_valid
    end
  end

  describe '#own?' do
    let(:other_user) { User.new(id: 2) }
    before { user.id = 1 }

    it '自身のオブジェクトならtrueを返す' do
      object = double(user_id: 1)
      expect(user.own?(object)).to be true
    end

    it '他人のオブジェクトならfalseを返す' do
      object = double(user_id: 2)
      expect(user.own?(object)).to be false
    end
  end
end

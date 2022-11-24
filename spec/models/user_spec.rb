require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "accountを指定しているとき" do
    it "ユーザーが作られる" do
      # binding.pry
      user = build(:user)
      # user = User.new(name: "foo", account: "foo", email: "foo@example.com")
      # expect(user.valid?).to eq true
      expect(user).to be_valid
    end
  end

  context "accountを指定していないとき" do
    it "ユーザーが作られない" do
      user = build(:user, account: nil)
      # user = User.new(name: "foo",  email: "foo@example.com")
      expect(user).to be_invalid
      # binding.pry
      expect(user.errors.details[:account][0][:error]).to eq :blank
    end
  end

  # context "まだ同じ名前のアカウントが存在しないとき" do
  #   it "ユーザーが作られる" do
  #     user = User.new(name: "foo", account: "foo", email: "foo@example.com")
  #     expect(user).to be_valid
  #   end
  # end

  context "既に同じ名前のアカウントが存在しているとき" do
    before { create(:user,account: "foo") }
    # before { build(:user) }
    it "ユーザーが作られない" do
      # user = create(:user, account: "foo")
      user = build(:user, account: "foo")
      # User.create!(name: "foo",account: "foo", email: "foo@example.com")
      # user = User.new(name: "ttt", account: "foo", email: "ttt@example.com")
      expect(user).to be_invalid
      expect(user.errors.details[:account][0][:error]).to eq :taken
      # binding.pry
    end
  end
end

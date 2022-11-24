require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    subject { get users_path }
    before do
      # 3.times {create(:user)}
      create_list(:user, 3)
      #上のやつは同じ意味
    end
    fit "ユーザーの一覧が見れる" do
      # 3.times {create(:user)}
      # binding.pry
      subject

      binding.pry
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "account", "name", "created_at", "updated_at", "email"]
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/:id" do
    it "任意のユーザーのレコード値が見れる" do
    end
  end

  describe "POST /users/:id" do
    it "ユーザーのレコードが作成できる" do
    end
  end

  describe "PATCH /users/:id" do
    it "ユーザーのレコードが更新できる" do
    end
  end

  describe "DELETE /users/:id" do
    it "ユーザーのレコードが削除できる" do
    end
  end
end

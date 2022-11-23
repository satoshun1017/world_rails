require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "ユーザーの一覧が見れる" do
      get users_path
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

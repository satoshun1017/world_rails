require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    subject { get users_path }
    before do
      # 3.times {create(:user)}
      create_list(:user, 3)
      #上のやつは同じ意味
    end
    it "ユーザーの一覧が見れる" do
      # 3.times {create(:user)}
      # binding.pry
      subject

      # binding.pry
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "account", "name", "created_at", "updated_at", "email"]
      expect(response).to have_http_status(200)
    end
  end

  # describe "GET /users/:id" do
  #   subject { get(user_path(user_id)) }

  #   context "指定したidのユーザーが存在するとき" do
  #     let(:user_id) { user.id }
  #     let(:user) { create(:user) }
  #   fit "そののユーザーのレコード値が見れる" do
  #     subject
  #     binding.pry
  #     expect(response).to have_http_status(200)
  describe "GET /users/:id" do
    subject { get(user_path(user_id)) }

    context "指定した id のユーザーが存在する場合" do
      let(:user) { create(:user) }
      let(:user_id) { user.id }

      it "そのユーザーのレコードが取得できる" do
        subject
        # binding.pry
        res = JSON.parse(response.body)
        expect(res["name"]).to eq user.name
        expect(res["account"]).to eq user.account
        expect(res["email"]).to eq user.email

        expect(response).to have_http_status(200)
    end
   end

    context "指定したidのユーザーが存在しないとき" do
      let(:user_id) {10000}


      fit "ユーザーが見つからない" do
        # binding.pry
        # subject
        expect { subject }.to raise_error ActiveRecord::RecordNotFound

      end
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

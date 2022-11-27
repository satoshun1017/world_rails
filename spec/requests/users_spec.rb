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
      it "ユーザーが見つからない" do
        # binding.pry
        # subject
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST /users/:id" do
    subject { post(users_path, params: params) }

    context "適切なパラメーターが送られた時" do
      let(:params) { { user: attributes_for(:user)} }

    it "ユーザーのレコードが作成できる" do
      # binding.pry
      expect { subject }.to change { User.count }.by(1)
      # binding.pry
      res = JSON.parse(response.body)
      expect(res["name"]).to eq params[:user][:name]
      expect(res["account"]).to eq params[:user][:account]
      expect(res["email"]).to eq params[:user][:email]
      expect(response).to have_http_status(200)

    end
   end

   context "不適切な送信したパラメータを送信したとき" do
    let(:params)  { attributes_for(:user)}
    it "エラーする" do
      # binding.pry
      expect { subject }.to raise_error(ActionController::ParameterMissing)
    end
   end
  end

  describe "PATCH /users/:id" do
    subject { patch(user_path(user_id), params: params) }
    let(:params) do
      { user: { name: Faker::Name.name, created_at: 1.day.ago } }
    end
    let(:user_id) { user.id }
    let(:user) { create(:user) }

    it "ユーザーのレコードが更新できる" do
      # subject
      expect { subject }.to change { User.find(user_id).name }.from(user.name).to(params[:user][:name]) &
                        not_change { User.find(user_id).account } &
                        not_change { User.find(user_id).email } &
                        not_change { User.find(user_id).created_at }
    end
  end

  describe "DELETE /users/:id" do
    subject { delete(user_path(user_id)) }
    let(:user_id) { user.id }
    let!(:user) { create(:user) }
    fit "ユーザーのレコードが削除できる" do
      expect { subject }.to change { User.count }.by(-1)
      # binding.pry
    end
  end
end

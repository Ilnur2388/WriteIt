require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "PATCH /update" do
    before do
      post session_path, params: { name: user.name, password: "password" }
    end

    let(:valid_params) { { user: { name: "Новое имя" } } }

    it "update user data" do
      patch user_path(user), params: valid_params
      user.reload
      expect(user.name).to eq("Новое имя")
      expect(response).to redirect_to(edit_user_path(user))
    end
  end
end

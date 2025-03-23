require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }
  let(:valid_params) { { post: { title: "Новый пост", body: "Текст поста", state: :draft } } }
  let(:invalid_params) { { post: { title: " ", body: "Текст поста", state: :draft } } }

  before do
    post session_path, params: { name: user.name, password: "password" }
  end

  describe "GET /new" do
    it "new post" do
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "create new post" do
      expect { post posts_path, params: valid_params }.to change(Post, :count).by(1)
      expect(response).to redirect_to(posts_path)
      expect(response.body).to include("Пост создан успешно!")
    end

    it "unable to create new post" do
      expect { post posts_path, params: invalid_params }.to_not change(Post, :count)
      expect(response.body).to include("Не удается создать пост!")
    end
  end

  describe "PATCH /update" do
    let(:update_params) { { post: { title: "Новый заголовок" } } }

    it "update post" do
      patch post_path(post), params: update_params
      post.reload
      expect(post.title).to eq("Новый заголовок")
      expect(response).to redirect_to(posts_path)
    end
  end

  describe "DELETE /destroy" do
    it "delete post" do
      expect { delete post_path(post) }.to change(Post, :count).by(-1)
      expect(response).to redirect_to(posts_path)
      expect(response.body).to include("Пост удален!")
    end
  end
end

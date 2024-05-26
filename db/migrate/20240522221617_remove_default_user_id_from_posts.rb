class RemoveDefaultUserIdFromPosts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :posts, :user_id, nil, from: User.first.id, to: nil
  end
end

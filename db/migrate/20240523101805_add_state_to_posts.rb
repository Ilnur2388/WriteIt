class AddStateToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :state, :integer, default: 0
  end
end

class AddCityToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :city, :string
  end
end

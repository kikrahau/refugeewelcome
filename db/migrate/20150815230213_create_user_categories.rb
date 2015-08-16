class CreateUserCategories < ActiveRecord::Migration
  def change
    create_table :categories_users do |t|
      t.integer :user_id
      t.integer :category_id
    end
  end
end

class CreateCategoryJobs < ActiveRecord::Migration
  def change
    create_table :categories_jobs,id: false do |t|
      t.integer :job_id
      t.integer :category_id
    end
  end
end

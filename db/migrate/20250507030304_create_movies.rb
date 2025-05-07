class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.float :vote_average
      t.integer :vote_count

      t.timestamps
    end
  end
end

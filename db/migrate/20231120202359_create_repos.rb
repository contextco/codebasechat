class CreateRepos < ActiveRecord::Migration[7.1]
  def change
    create_table :repos do |t|
      t.string :url
      t.string :email

      t.timestamps
    end
  end
end

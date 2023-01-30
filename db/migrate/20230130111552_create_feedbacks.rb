class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.integer  :quality
      t.string   :age_group
      t.integer  :nps
      t.string   :status
      t.datetime :experienced_at

      t.timestamps
    end

    add_reference :branches, :organization, foreign_key: true
    add_reference :feedbacks, :branch, foreign_key: true
  end
end

class CreateIterationHistories < ActiveRecord::Migration
  def self.up
    create_table :iteration_histories do |t|
      t.integer :version_id
      t.date :old_due_date
      t.date :new_due_date
      t.string :reason, :limit=>800, :null=>false,:default=>"Original due date"

      t.timestamps
    end
  end

  def self.down
    drop_table :iteration_histories
  end
end

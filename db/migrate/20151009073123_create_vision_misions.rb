class CreateVisionMisions < ActiveRecord::Migration
  def change
    create_table :vision_misions do |t|
      t.references	:candidate
      t.text	:vision
      t.text	:mision

      t.timestamps
    end
  end
end

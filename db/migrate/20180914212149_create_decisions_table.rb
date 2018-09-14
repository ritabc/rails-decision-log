class CreateDecisionsTable < ActiveRecord::Migration[5.2]
  def change

    create_table :circles do |t|
      t.column :name, :string
      t.column :description, :text
      t.timestamps
    end

    create_table :decisions do |t|
      t.column(:name, :string)
      t.column(:date_decided, :date)
      t.column(:description, :text)
      t.column(:review_by_date, :date)
      t.column(:supp_doc_one_type, :string)
      t.column(:supp_doc_one_link, :string)
      t.column(:supp_doc_two_type, :string)
      t.column(:supp_doc_two_link, :string)
      t.belongs_to :circle, index: true
      t.timestamps
    end
  end
end

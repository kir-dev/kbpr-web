class AddAcceptedTermsOfServiceToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :accepted_terms_of_service, :boolean
  end
end

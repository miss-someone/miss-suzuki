ActiveAdmin.register EmailDomain do
  actions :index, :new, :create, :show, :edit, :update, :delete

  permit_params :domain, :is_forbidden, :is_notified, :description

  index do
    selectable_column
    id_column
    column :domain
    column :is_forbidden
    column :is_notified
    column :description
  end
end

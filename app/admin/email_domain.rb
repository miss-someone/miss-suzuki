ActiveAdmin.register EmailDomain do
  actions :index, :new, :create, :show, :edit, :update, :delete

  permit_params :domain, :is_forbidden, :is_notified
end

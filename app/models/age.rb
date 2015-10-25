class Age < ActiveYaml::Base
  set_root_path Rails.root.join('db/fixtures')
  set_filename 'ages'
end

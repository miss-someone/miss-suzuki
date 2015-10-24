class Job < ActiveYaml::Base
  set_root_path Rails.root.join('db/fixtures')
  set_filename 'jobs'
end

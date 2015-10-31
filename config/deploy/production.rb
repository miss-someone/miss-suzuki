# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :branch, 'master'
set :rails_env, "production"
set :stage, 'production'

role :app, %w(webmaster@192.168.1.21 webmaster@192.168.1.22)
role :db, %w(webmaster@192.168.1.21)
role :contestant, %w(webmaster@192.168.1.21)

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

# server 'example.com', user: 'deploy', roles: %w{app}

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
set :ssh_options,
    keys: %w(/home/webmaster/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)

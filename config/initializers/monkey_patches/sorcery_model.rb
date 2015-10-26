# deliver_lateを使えるようにするためのモンキーパッチ
# 2015.10.26現在，リリースver.のsorceryに含まれていないため
module Sorcery
  module Model
    module InstanceMethods

      protected

      def generic_send_email(method, mailer)
        config = sorcery_config
        mail = config.send(mailer).send(config.send(method), self)
        if defined?(ActionMailer) and config.send(mailer).kind_of?(Class) and config.send(mailer) < ActionMailer::Base
          mail.deliver_later
        end
      end
    end
  end
end

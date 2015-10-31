# deliver_lateを使えるようにするためのモンキーパッチ
# 2015.10.26現在，リリースver.のsorceryに含まれていないため
module Sorcery
  module Model
    module InstanceMethods
      protected

      def generic_send_email(method, mailer)
        config = sorcery_config
        mail = config.send(mailer).send(config.send(method), self)
        unless defined?(ActionMailer) && config.send(mailer).is_a?(Class) && config.send(mailer) < ActionMailer::Base
          return
        end
        mail.deliver_later
      end
    end
  end
end

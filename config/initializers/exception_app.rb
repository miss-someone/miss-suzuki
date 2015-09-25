# ErrorsControllerにエラーページの表示を委譲する
Rails.configuration.exceptions_app = ->(env) { ErrorsController.action(:show).call(env) }

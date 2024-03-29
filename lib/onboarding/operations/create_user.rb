require 'dry-monads'

module Onboarding
  module Operations
    class CreateUser
      include Dry::Monads[:result, :try]

      def call(args)
        failure_message = 'too many subscriptions! Try again later'
        return fail!(failure_message) if User.count > 0

        User.create!(args)
        # schedule_email(args)

        Success()
      end

      private

      def fail!(message)
        Failure[:teapot, message: message]
      end
    end
  end
end

module TrailblazerExecutor
  module ControllerAdditions
    module ClassMethods
      def execute_and_authorize_operation
        executor_resource_class.add_before_action(self, :execute_and_authorize_operation)
      end

      def execute_operation
        executor_resource_class.add_before_action(self, :execute_operation)
      end

      def executor_resource_class
        ControllerResource
      end
    end

    def authorize!(result)
      return unless result['result.policy.user']

      raise NotAuthorized if result['result.policy.user'].failure?
    end

    def self.included(base)
      base.extend ClassMethods
    end
  end
end

if defined? ActiveSupport
  ActiveSupport.on_load(:action_controller) do
    include TrailblazerExecutor::ControllerAdditions
  end
end

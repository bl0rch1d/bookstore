module TrailblazerExecutor
  class Executor
    PRESENT_ACTIONS = %w[edit new].freeze
    ACTION_METHOD_MAPPINGS = {
      new: :create,
      edit: :update,
      index: :index,
      create: :create,
      show: :show,
      update: :update,
      destroy: :destroy
    }.freeze

    def self.add_before_action(controller_class, method)
      controller_class.send(:before_action) do |controller|
        controller.class.executor_class.new(controller).send(method)
      end
    end

    def initialize(controller, operation_params: nil)
      @controller = controller
      @controller_params = controller.params

      @operation_params = operation_params || prepare_params_for_operation
    end

    def execute_and_authorize_operation
      execute_operation
      authorize!
    end

    def execute_operation(klass: operation_class)
      @operation_result = Module.const_get(klass).call(@operation_params)

      @controller.instance_variable_set(:@operation_result, @operation_result)
    end

    def authorize!
      @controller.authorize!(@operation_result)
    end

    private

    def operation_class
      return "#{operation_module}::#{operation_name}::Present" if PRESENT_ACTIONS.include?(@controller.action_name)

      "#{operation_module}::#{operation_name}"
    end

    def operation_module
      ActiveSupport::Inflector.singularize(@controller.class.to_s.gsub('Controller', ''))
    end

    def operation_name
      ACTION_METHOD_MAPPINGS[@controller.action_name.intern].capitalize
    end

    def prepare_params_for_operation
      @controller_params.merge(current_user: @controller.current_user, current_order: @controller.current_order)
    end
  end
end

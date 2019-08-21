class Checkout::Processor
  def initialize(controller:, action:, step:)
    @controller = controller
    @action = action
    @step = step
  end

  def call
    @executor = TrailblazerExecutor::Executor.new(@controller, operation_params: operation_params)

    execute
    authorize
  end

  private

  def execute
    @executor.execute_operation(klass: operation_class)
  end

  def authorize
    @executor.authorize!
  end

  def operation_params
    @controller.params.merge(
      current_order: @controller.current_order,
      current_user: @controller.current_user,
      step: @step
    )
  end

  def operation_class
    return "Checkout::#{@step.capitalize}::Present" if @action == 'show' && @step != :complete

    "Checkout::#{@step.capitalize}"
  end
end

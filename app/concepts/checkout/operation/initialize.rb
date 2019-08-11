class Checkout::Initialize < Trailblazer::Operation
  success :set_user

  def set_user(_ctx, params:, **)
    params[:current_order].update(user_id: params[:current_user].id)
  end
end

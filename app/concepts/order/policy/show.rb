class Order::Policy::ShowPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    @user.present? && @record.user_id == @user.id
  end
end

class ReviewPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    @user.present?
  end
end

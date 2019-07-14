class CategoryDecorator < Draper::Decorator
  delegate_all

  def system_format
    title.downcase.tr(' ', '_')
  end
end

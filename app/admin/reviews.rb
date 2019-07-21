# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Review do
  permit_params :body, :rating, :state

  scope :all
  scope :unprocessed
  scope :processed
  scope :approved
  scope :rejected

  action_item :approve, only: :show do
    if review.state == I18n.t('review.states.unprocessed')
      link_to I18n.t('review.admin_actions.approve'), approve_admin_review_path(review), method: :put
    end
  end

  action_item :reject, only: :show do
    if review.state == I18n.t('review.states.unprocessed')
      link_to I18n.t('review.admin_actions.reject'), reject_admin_review_path(review), method: :put
    end
  end

  member_action :approve, method: :put do
    review = Review.find(params[:id])

    review.approve!

    redirect_to admin_review_path(review)
  end

  member_action :reject, method: :put do
    review = Review.find(params[:id])

    review.reject!

    redirect_to admin_review_path(review)
  end

  index do
    selectable_column

    column :book
    column :created_at
    column :customer
    column :state

    column do |resource|
      link_to I18n.t('link_to.show'), resource_path(resource)
    end
  end
end
# rubocop:enable Metrics/BlockLength

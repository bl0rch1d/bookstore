ActiveAdmin.register Review do
  permit_params :body, :rating, :state

  scope :all
  scope :unprocessed
  scope :processed
  scope :approved
  scope :rejected

  action_item :approve, only: :show do
    link_to 'Approve', approve_admin_review_path(review), method: :put if review.state != :approved
  end

  action_item :reject, only: :show do
    link_to 'Reject', reject_admin_review_path(review), method: :put if review.state != :rejected
  end

  member_action :approve, method: :put do
    review = Review.find(params[:id])
    review.update(state: :approved)
    redirect_to admin_review_path(review)
  end

  member_action :reject, method: :put do
    review = Review.find(params[:id])
    review.update(state: :rejected)
    redirect_to admin_review_path(review)
  end

  index do
    selectable_column

    column :book
    column :created_at
    column :customer
    column :state

    column do |resource|
      link_to 'show', resource_path(resource)
    end
  end
end

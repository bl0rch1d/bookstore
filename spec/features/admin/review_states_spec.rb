describe 'Review states' do
  before do
    create(:review, state: I18n.t('review.states.unprocessed'))
    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_reviews_path
    click_link(I18n.t('link_to.show'))
  end

  context 'when admin changes review state' do
    it 'from unprocessed to approved' do
      click_link(I18n.t('admin.review.actions.approve'))

      expect(page).to have_content(I18n.t('review.states.approved'))
      expect(Review.last.state).to eq(I18n.t('review.states.approved'))
    end

    it 'from unprocessed to rejected' do
      click_link(I18n.t('admin.review.actions.reject'))

      expect(page).to have_content(I18n.t('review.states.rejected'))
      expect(Review.last.state).to eq(I18n.t('review.states.rejected'))
    end
  end
end

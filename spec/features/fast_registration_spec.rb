RSpec.describe 'Fast registration', type: :feature do
  it 'user can register without password' do
    create :book

    visit root_path

    click_link('Buy Now')

    visit cart_index_path

    click_link('Checkout')

    expect(page).to have_current_path('/users/fast_new')

    within '#fastCreate' do
      fill_in 'user[email]',	with: 'qwerty@example.com'

      click_button('Contine to Checkout')
    end

    expect(page).to have_content('You have to confirm your email address before continuing.')
  end
end

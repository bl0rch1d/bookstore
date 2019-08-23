describe 'Books spec' do
  before do
    create(:book)
    create_list(:material, 3)
    create_list(:category, 3)
    create_list(:author, 3)

    admin_user = create(:admin_user)
    login_as(admin_user, scope: :admin_user)

    visit admin_books_path
  end

  let(:book_attributes) { attributes_for(:book) }

  it 'Admin can create a Book' do
    click_link(I18n.t('admin.book.new'))

    expect(page).to have_current_path(new_admin_book_path)

    within '#new_book' do
      fill_in 'book[title]', with: book_attributes[:title]

      choose('book[category_id]', option: '1')

      check('book_author_ids_1')

      fill_in 'book[description]',  with: book_attributes[:description]
      fill_in 'book[year]',         with: book_attributes[:year]
      fill_in 'book[price]',        with: book_attributes[:price]

      check('book_material_ids_1')

      fill_in 'book[height]',       with: book_attributes[:height]
      fill_in 'book[width]',        with: book_attributes[:width]
      fill_in 'book[depth]',        with: book_attributes[:depth]
      fill_in 'book[quantity]',     with: book_attributes[:quantity]

      click_button(I18n.t('admin.book.create'))
    end

    expect(page).to have_current_path(admin_book_path(Book.last))
  end

  it 'Admin can view the Book' do
    click_link(I18n.t('admin.actions.view'), match: :first)

    expect(page).to have_current_path(admin_book_path(Book.first))
  end
end

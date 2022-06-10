class Category < ApplicationRecord
  belongs_to :book,optional: true
  has_many :book_categories,dependent: :destroy, foreign_key: 'category_id'
  has_many :books,through: :book_categories

  scope :merge_books, -> (categories){ }

  def self.looks(content, method)

    if method == 'perfect'
      categories = Category.where(name: content)
    elsif method == 'forward'
      categories = Category.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      categories = Category.where('name LIKE ?', '%' + content)
    else
      categories = Category.where('name LIKE ?', '%' + content + '%')
    end

    return categories.inject(init = []) {|result, category| result + category.books}

  end

end

# frozen_string_literal: true
class Me::BooksController < ApplicationController
  layout 'me/books'

  def index
    @show = (params[:show] || 'in_hand').underscore
    @books = books_scope(@show).reorder(updated_at: :desc)
  end

  private

  def books_scope(show = nil)
    case show
    when 'in_hand'
      current_user.holding_books
    when 'ready_for_release'
      current_user.holding_books.where('book_holdings.state = ?', 'ready_for_release')
    else
      current_user.past_holded_books
    end
  end

  def find_book
    @book = books_scope.find(params[:book_id] || params[:id])
  end
end

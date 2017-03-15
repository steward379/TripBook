# frozen_string_literal: true
class BookInfo < ApplicationRecord
  self.primary_key = :isbn

  has_one :cover_image, primary_key: :isbn, foreign_key: :isbn, autosave: true
  has_many :books, primary_key: :isbn, foreign_key: :isbn
  has_many :book_holdings, through: :books, source: :holdings, class_name: 'Book::Holding'
  has_many :book_stories, primary_key: :isbn, foreign_key: :book_isbn, class_name: 'Book::Story'
  has_many :book_summaries, primary_key: :isbn, foreign_key: :book_isbn, class_name: 'Book::Summary'

  validates :isbn, :name, presence: true
  validates :isbn, uniqueness: true, on: :create
end

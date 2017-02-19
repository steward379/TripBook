# frozen_string_literal: true
class BookInfo < ApplicationRecord
  self.primary_key = :isbn

  has_one :cover_image, primary_key: :isbn, foreign_key: :isbn
  has_many :books, primary_key: :isbn, foreign_key: :isbn

  validates :isbn, :name, presence: true
end

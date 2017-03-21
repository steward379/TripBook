# frozen_string_literal: true
FactoryGirl.define do
  factory :book_info do
    isbn do
      until @isbn =~ BookInfo::ISBN_REGEXP
        @isbn = Faker::Code.isbn.gsub(/[^0-9]/, '')
      end
      @isbn
    end
    isbn_13 { isbn }
    name { Faker::Book.title }
    author { Faker::Book.author }
    publisher { Faker::Book.publisher }
    publish_date { Faker::Date.between(20.years.ago, 1.day.ago) }

    trait :with_cover_image do
      association :cover_image, factory: :book_info_cover_image
    end
  end
end

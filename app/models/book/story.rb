# frozen_string_literal: true
class Book::Story < ApplicationRecord
  include Trackable

  enum privacy_level: {
    only_me: 0,
    only_by_invitation: 1,
    open_to_world: 15
  }

  scope :for, ->(user) { where(user: user) }
  scope :for_isbn, ->(isbn) { where(book_isbn: isbn) }
  scope :published, -> { where.not(published_at: nil) }

  belongs_to :user
  belongs_to :book_info, primary_key: :isbn, foreign_key: :book_isbn
  belongs_to :book,
             ->(o) { joins(:past_holders).where('users.id' => o.user_id).order('book_holdings.updated_at DESC') },
             primary_key: :isbn, foreign_key: :book_isbn, optional: true

  def publish
    published_at.present?
  end

  def publish=(publish)
    if parse_boolean(publish)
      self.published_at ||= Time.current
    else
      self.published_at = nil
    end
  end

  alias published? publish

  def content_for(user_type)
    return unless published?
    case user_type.to_sym
    when :self
      content
    when :invitee
      content if privacy_level_before_type_cast >= 1
    when :follower
      content if privacy_level_before_type_cast >= 2
    else
      content if privacy_level_before_type_cast >= 3
    end
  end
end

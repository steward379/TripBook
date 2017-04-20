# frozen_string_literal: true
module BooksHelper
  def book_cover(
    book,
    show_placeholder: true,
    responsive: false,
    max_width: 296.0,
    max_height: 420.0,
    html_class: nil,
    style: nil,
    href: nil
  )
    book.build_cover_image if show_placeholder && book.cover_image.blank?
    return if book.cover_image.blank?
    dimensions = book.cover_image.dimensions(max_width: max_width, max_height: max_height)
    book_cover_tag = href.present? ? :a : :div

    content_tag(
      book_cover_tag,
      class: ['book-cover', responsive && 'book-cover-responsive', html_class],
      style: style,
      href: href,
      'data-width': dimensions[0],
      'data-height': dimensions[1],
      'data-id': book.id
    ) do
      if book.cover_image.image.present?
        concat image_tag(book.cover_image&.image&.medium&.url)
      else
        concat content_tag(:div, book.name, class: 'title')
      end

      yield(book) if block_given?
    end
  end
end

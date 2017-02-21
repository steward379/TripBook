//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require select2-full
//= require jquery-fileupload/basic

import BookInfoInput from './components/book_info_input'
import BasicImageUploaderInput from './components/basic_image_uploader_input'

const components = {}

$(document).on('turbolinks:load', () => {
  components.bookInfoInputs = $('.book_info_input').toArray().map(el => new BookInfoInput(el))
  components.basicImageUploaderInput = $('.basic_image_uploader_input').toArray().map(el => new BasicImageUploaderInput(el))
})

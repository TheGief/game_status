module ApplicationHelper

  def cover_img(item, edit = false)
    path = edit ? eval("edit_#{item.class.to_s.downcase}_path(item)") : item
    link_to image_tag(item.image_url, class: 'cover_img'), path
  end

end
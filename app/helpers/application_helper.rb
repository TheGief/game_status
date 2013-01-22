module ApplicationHelper
  def cover_img(item, edit = false)
    path = edit ? send("edit_#{item}_path(item)") : item
    link_to image_tag(item.image_url, class: 'cover_img'), path
  end
end

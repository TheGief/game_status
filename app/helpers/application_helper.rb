module ApplicationHelper

  def cover_img(item, edit = false)
    path = edit ? eval("edit_#{item.class.to_s.downcase}_path(item)") : item
    link_to image_tag(item.image_url, class: 'cover_img'), path
  end

  def img_url(*args)
    options = args.extract_options!
    'http://images.weserv.nl?' + 'url=' + URI.escape(args[0]) + '&' + options.to_query
  end

end
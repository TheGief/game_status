module ConsolesHelper
  def console_img(console, edit = false)
    path = edit ? edit_console_path(console) : console
    link_to image_tag(console.image_url, class: 'console'), path, :class => "img-rounded"
  end
end

module UsersHelper
  def count(item)
    pluralize(item.count, item.model_name.downcase)
  end
end

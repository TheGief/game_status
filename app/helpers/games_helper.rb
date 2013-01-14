module GamesHelper
  def cover_img(game, edit = false)
    path = edit ? edit_game_path(game) : game
    link_to image_tag(game.image_url, class: 'cover_img'), path
  end
end

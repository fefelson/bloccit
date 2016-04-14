module PostsHelper
  include AuthorizePost #Found in app/controllers/concerns/authorize_post.rb

  def user_is_authorized_for_post?(post)
    current_user && (current_user == post.user || current_user.admin?)
  end

  def user_is_authorized_for_post_edit?(post)
    current_user && (current_user == post.user || current_user.admin? || current_user.moderator?)
  end
end

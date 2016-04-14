module AuthorizePost
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def can_show_post?
    true
  end
  
  def can_index_post?
    true
  end
  
  def can_edit_post?(post)
    can_update_post?(post)
  end
  
  def can_update_post?(post)
    return false unless current_user.present?
    return true if current_user.admin? || current_user.moderator?
    current_user == post.user
  end
  
  def can_new_post?
    can_create_post?
  end
  
  def can_create_post?
    current_user.present?
  end
  
  def can_destroy_post?(post)
    return false unless current_user.present?
    return true if current_user.admin?
    current_user == post.user
  end

end
module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friendship_button(user)
    return unless !current_user.friends?(user) && current_user.id != user.id && !current_user.friend_requests?(user)

    link_to('Invite friendship', friend_requests_path(user: user), method: :post, class: 'card-link text-success')
  end

  def unfriend_btn(user)
    return unless current_user.friends?(user) && current_user.id != user.id

    link_to('Remove friendship', friendship_path(id: user.id), method: :delete, class: 'card-link text-danger')
  end

  def pending_status(user)
    return unless current_user.id != user.id

    if current_user.friends?(user)
      content_tag :span, 'Friend', class: 'text-muted ml-2'
    elsif current_user.friend_requests_as_sender.exists?(receiver: user)
      content_tag :span, 'request pending', class: 'text-muted ml-2'
    elsif current_user.friend_requests_as_receiver.exists?(sender: user)
      content_tag :span, 'request received', class: 'text-muted ml-2'
    end
  end
end

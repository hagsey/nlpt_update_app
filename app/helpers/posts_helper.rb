module PostsHelper
  def preview(text, size)
    text_size = text.split.length

    if text_size <= size 
      text 
    else
      text.split.take(size).join(" ") + "..."
    end
  end

  def post_owner(post)
    current_user.full_name == post.author
  end
end

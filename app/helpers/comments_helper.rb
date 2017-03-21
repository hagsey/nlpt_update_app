module CommentsHelper
    def comment_owner(comment)
    current_user.full_name == comment.author
  end

end

module UsersHelper
  def current_user_or_admin?(user)
    current_user == user || current_user.admin?
  end
end

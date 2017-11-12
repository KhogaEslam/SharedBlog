module ArticlesHelper
  def authorized?(article)
    current_user == article.user
  end
end

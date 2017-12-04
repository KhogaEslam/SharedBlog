module SessionsHelper
  # Logs in the given author.
  def log_in(author)
    session[:author_id] = author.id
  end

  # Remembers a author in a persistent session.
  def remember(author)
    author.remember
    cookies.permanent.signed[:author_id] = author.id
    cookies.permanent[:remember_token] = author.remember_token
  end

  # Returns true if the given author is the current author.
  def current_author?(author)
    author == current_author
  end

  # Returns true if the given author is the current publisher.
  def current_publisher?(article)
    article.author == current_author
  end

  # Returns the current logged-in author (if any).
  def current_author
    if (author_id = session[:author_id])
      @current_author ||= Author.find_by(id: author_id)
    elsif (author_id = cookies.signed[:author_id])
      author = Author.find_by(id: author_id)
      if author && author.authenticated?(cookies[:remember_token])
        log_in author
        @current_author = author
      end
    end
  end

  # Returns true if the author is logged in, false otherwise.
  def logged_in?
    !current_author.nil?
  end

  # Logs out the current author.
  def log_out
    forget(current_author)
    session.delete(:author_id)
    @current_author = nil
  end

  # Forgets a persistent session.
  def forget(author)
    author.forget
    cookies.delete(:author_id)
    cookies.delete(:remember_token)
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end

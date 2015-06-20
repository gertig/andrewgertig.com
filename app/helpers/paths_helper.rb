module PathsHelper

  def admin_path
    user_signed_in? ? dashboard_path : "/auth/identity"
  end

  def author_path(user)
    "/#{user.name.downcase}"
  end

  def blogpost_path(post)
    if !post.published_at.nil?
      time = post.published_at.strftime("%Y/%m")
      # path = "/#{time}/#{post.slug}"

      path = post.url_contains_date? ? "/#{time}/#{post.slug}" : "/#{post.slug}"
    else
      path = post
    end

    path
  end

  def page_path_helper(page)
    !page.published_at.nil? ? "/#{page.slug}" : page
  end

end

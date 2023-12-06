module PostsHelper
  def index_actions_for(post)
    html = ''.html_safe

    html << content_tag(:a, class: 'sortable-handle', data: { controller: "action-authorisations", action_authorisations_target: "user" }) do
      Icon.call("drag")
    end
  
    html << link_to(edit_post_path(post), target: "_top", data: { controller: "action-authorisations", action_authorisations_target: "user" }) do
      Icon.call("edit")
    end
  
    html << button_to(post_path(post), method: :delete, data: { turbo_confirm: "Are you sure?", controller: "action-authorisations", action_authorisations_target: "user" }, class: "button") do
      Icon.call("trash")
    end
  
    html
  end

  def form_back_link(post, user)
    if post.new_record?
      link_to sanitize("&larr; Back to posts"), user_posts_path(user)
    else
      link_to sanitize("&larr; Back to post"), post_path(post)
    end
  end

  def show_actions_for(post)
    html = ''.html_safe

    html << link_to(edit_post_path(post), target: "_top") do
      Icon.call("edit")
    end
  
    html << button_to(post_path(post), method: :delete, data: { controller: "confirmation", action: "click->confirmation#confirm", turbo: false }, class: "button") do
      Icon.call("trash")
    end
  
    html
  end
end
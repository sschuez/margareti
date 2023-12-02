module SidebarHelper
  def sign_out_button(text, path, icon_name)
    content_tag :li do
      button_to path, method: :delete, class: "sidebar__item" do
        safe_join([Icon.new(icon_name).call, text], " ")
      end
    end
  end

  def admin_sidebar_button(links = [])
    content_tag :li do
      button_tag class: "sidebar__item toggle", data: { action: "click->sidebar#toggleSub" } do
        concat Icon.new("admin").call
        concat content_tag(:span, 'Admin')
        concat content_tag(:div, nil, data: { sidebar_target: "arrowIcon" })
        concat content_tag(:div, class: "toggle-sub", id: "sub") {
          content_tag(:ul) {
            safe_join(links.map { |link| content_tag(:li, link_to(link[:text], link[:path])) }, "\n")
          }
        }
      end
    end
  end

  # def user_profile_link(user)
  #   content_tag :li do
  #     link_to user_path(user), class: "sidebar__item" do
  #       safe_join([
  #         AvatarPresenter.call(
  #           user: user, 
  #           extra_classes: {
  #             avatar: ["avatar-circle--small"],
  #             text: ["avatar-text--small"]
  #           }
  #         ),
  #         content_tag(:span, t("users.profile").capitalize)
  #       ], " ")
  #     end
  #   end
  # end

  def sidebar_item(text, path, icon)
    content_tag :li do
      link_to path, class: "sidebar__item" do
        concat Icon.call(icon)
        concat content_tag :span, text
      end
    end
  end

  def divider
    content_tag :li do
      content_tag :div, nil, class: "divider"
    end
  end

  # def sidebar_button_turbo(text, path, icon_name)
  #   content_tag :li, class: "sidebar__item--btn", data: { action: "click->sidebar#closeSidebar" } do
  #     link_to path, data: { controller: "turbo" }, class: "my-btn my-btn--dark" do
  #       safe_join([Icon.call(icon_name), text], " ")
  #     end
  #   end
  # end

  def sidebar_button(text, path, icon_name)
    content_tag :li, class: "sidebar__item--btn" do
      link_to path, class: "my-btn my-btn--primary" do
        safe_join([Icon.new(icon_name).call, text], " ")
      end
    end
  end
end

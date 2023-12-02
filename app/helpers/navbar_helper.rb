module NavbarHelper
  def navbar_link(text, path, classes = "navbar__list__item-link")
    content_tag :li, class: "navbar__list__item" do
      link_to text, path, class: classes
    end
  end

  def navbar_button(text, path, method: :get, classes: "button button--navbar navbar__list__item-link")
    content_tag :li, class: "navbar__list__item" do
      button_to text, path, method: method, class: classes
    end
  end

  def navbar_toggle_buttons
    hamburger_icon = Icon.new("hamburger").call
    close_icon = Icon.new("close").call
  
    html = <<-HTML
      <div class="mobile mobile__menu" data-action="click->navbar#open" data-navbar-target="menu">
        #{hamburger_icon}
      </div>
      <div class="close-icon" data-action="click->navbar#open" data-navbar-target="close">
        #{close_icon}
      </div>
    HTML
  
    html.html_safe
  end
end

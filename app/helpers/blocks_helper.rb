module BlocksHelper
  def actions_for(object)
    edit_path = object.is_a?(Block) ? edit_block_path(object) : edit_item_path(object)
    delete_path = object.is_a?(Block) ? block_path(object) : item_path(object)
    
    html = ''.html_safe
  
    html << link_to("#", class: "sortable-handle", data: { controller: "action-authorisations", action_authorisations_target: "user"}) do
      Icon.call("drag")
    end

    html << link_to(edit_path, class: "action-btn", data: { controller: "action-authorisations", action_authorisations_target: "user"}) do
      Icon.call("edit")
    end
  
    html << button_to(delete_path, method: :delete, data: { turbo_confirm: "Are you sure?", controller: "action-authorisations", action_authorisations_target: "user" }, class: "button action-btn") do
      Icon.call("trash")
    end
  
    html
  end

  def accordion_toggle_btn(item)
    # if item.content.present?
      content_tag :div, Icon.call("plus"), data: { action: "click->accordion#toggle", accordion_target: "icon", action_authorisations_target: "accordion" }, class: "button"
    # end
  end

  def item_content_edit_btn(item)
    return unless item.has_content?
   
    content_tag :div, data: { controller: "action-authorisations", action_authorisations_target: "user" }, class: "block__item__content--edit flex-end" do
      link_to edit_item_content_path(item, data: { turbo_frame: nested_dom_id(item, "edit_content") }, class: "action-btn") do
        Icon.call("edit")
      end
    end
  end
end
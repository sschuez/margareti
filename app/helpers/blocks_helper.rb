module BlocksHelper
  def actions_for(object)
    edit_path = object.is_a?(Block) ? edit_user_block_path(object.user, object) : edit_block_item_path(object.block, object)
    delete_path = object.is_a?(Block) ? block_path(object) : item_path(object)
    
    html = ''.html_safe
  
    html << link_to("#", class: "sortable-handle") do
      Icon.call("drag")
    end

    html << link_to(edit_path) do
      Icon.call("edit")
    end
  
    html << button_to(delete_path, method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "button") do
      Icon.call("trash")
    end
  
    html
  end

  def accordion_toggle_btn(item)
    # if item.content.present?
      content_tag :div, Icon.call("plus"), data: { action: "click->accordion#toggle", accordion_target: "icon" }, class: "button"
    # end
  end

  def item_content_edit_btn(item)
    return unless item.content.present?
   
    content_tag :div, class: "block__item__content--edit flex-end" do
      link_to edit_item_content_path(item, data: { turbo_frame: nested_dom_id(item, "edit_content") }) do
        Icon.call("edit")
      end
    end
  end

end
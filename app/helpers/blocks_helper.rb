module BlocksHelper
  def actions_for(object)
    edit_path = object.is_a?(Block) ? edit_user_block_path(object.user, object) : edit_block_item_path(object.block, object)
    delete_path = object.is_a?(Block) ? block_path(object) : item_path(object)
    
    html = ''.html_safe
  
    html << link_to(edit_path) do
      Icon.call("edit")
    end
  
    html << button_to(delete_path, method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "button") do
      Icon.call("trash")
    end
  
    html
  end
end
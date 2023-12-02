class Icon
  def self.call(*args, &block)
    new(*args, &block).call
  end
  
  def initialize(icon)
    @icon = icon
    @icons = {
      trash: '<i class="fas fa-trash-alt"></i>',
      edit: '<i class="fas fa-edit"></i>',
      confirm: '<i class="bi bi-check-circle-fill"></i>',
      cancel: '<i class="bi bi-x-circle-fill"></i>',
      handle: '<i class="bi bi-grip-horizontal handle mt-xxs ml-s"></i>',
      repeat: '<i class="bi bi-arrow-repeat"></i>',
      hamburger: '<i class="bi bi-list hamburger"></i>',
      close: '<i class="bi bi-x"></i>',
      close_lg: '<i class="bi bi-x-lg"></i>',
      sign_out: '<i class="bi bi-box-arrow-right"></i>',
      sign_in: '<i class="bi bi-box-arrow-in-right"></i>',
      published: '<i class="fas fa-eye"  style="color: hsla(152, 65%, 31%, 1)"></i>',
      unpublished: '<i class="fas fa-eye-slash" style="color: hsla(27, 67%, 57%, 1)"></i>',
      translate: '<i class="bi bi-translate"></i>',
      info: '<i class="bi bi-info-circle" style="color: hsl(210, 100%, 82%)"></i>',
      drag: '<i class="fas fa-grip-horizontal"></i>',
      plus: '<i class="fas fa-plus"></i>',
      edit_emoji: '<i class="emoji">✍️</i>',
      confirm_emoji: '<i class="emoji">👍</i>',
      cancel_emoji: '<i class="emoji">❌</i>',
      bin_emoji: '<i class="emoji">🗑️</i>'
    }
  end

  def call
    @icons[@icon.to_sym].html_safe
  end
end

class Icon
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(icon)
    @icon = icon
    @icons = {
      trash: '<i class="fas fa-trash-alt"></i>',
      book: '<i class="fab fa-readme"></i>',
      edit: '<i class="fas fa-edit"></i>',
      confirm: '<i class="bi bi-check-circle-fill"></i>',
      cancel: '<i class="bi bi-x-circle-fill"></i>',
      handle: '<i class="bi bi-grip-horizontal handle mt-xxs ml-s"></i>',
      repeat: '<i class="bi bi-arrow-repeat"></i>',
      hamburger: '<i class="fas fa-bars"></i>',
      close: '<i class="fas fa-times"></i>',
      close_lg: '<i class="bi bi-x-lg"></i>',
      sign_out: '<i class="fas fa-sign-out-alt"></i>',
      sign_in: '<i class="fas fa-sign-in-alt"></i>',
      published: '<i class="fas fa-eye"  style="color: hsla(152, 65%, 31%, 1)"></i>',
      unpublished: '<i class="fas fa-eye-slash" style="color: hsla(27, 67%, 57%, 1)"></i>',
      translate: '<i class="bi bi-translate"></i>',
      info: '<i class="bi bi-info-circle" style="color: hsl(210, 100%, 82%)"></i>',
      drag: '<i class="fas fa-grip-horizontal"></i>',
      plus: '<i class="fas fa-plus"></i>',
      edit_emoji: '<i class="emoji">✍️</i>',
      up: '<i class="fas fa-sort-up"></i>',
      down: '<i class="fas fa-sort-down"></i>',
      confirm_emoji: '<i class="emoji">👍</i>',
      cancel_emoji: '<i class="emoji">❌</i>',
      bin_emoji: '<i class="emoji">🗑️</i>'
    }
  end

  def call
    @icons[@icon.to_sym].html_safe
  end
end

class Icon
  def initialize(icon)
    @icon = icon
    @icons = {
      trash: '<i class="bi bi-trash-fill"></i>',
      edit: '<i class="bi bi-pencil-fill"></i>',
      confirm: '<i class="bi bi-check-circle-fill"></i>',
      cancel: '<i class="bi bi-x-circle-fill"></i>',
      handle: '<i class="bi bi-grip-horizontal handle mt-xxs ml-s"></i>',
      repeat: '<i class="bi bi-arrow-repeat"></i>',
      hamburger: '<i class="bi bi-list hamburger"></i>',
      close: '<i class="bi bi-x"></i>',
      close_lg: '<i class="bi bi-x-lg"></i>',
      sign_out: '<i class="bi bi-box-arrow-right"></i>',
      sign_in: '<i class="bi bi-box-arrow-in-right"></i>',
      translate: '<i class="bi bi-translate"></i>'
    }
  end

  def call
    @icons[@icon.to_sym].html_safe
  end
end

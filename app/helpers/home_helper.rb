module HomeHelper
  def bold_css(action_name)
    controller.action_name == action_name ? 'bold' : ''
  end
end
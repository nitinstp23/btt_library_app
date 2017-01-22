module ApplicationHelper

  BOOTSTRAP_FLASH_MSG = {
    notice: 'alert-success',
    alert: 'alert-danger'
  }

  def flash_messages(opts = {})
    html = flash.collect do |msg_type, message|
      render_flash_message(msg_type, message)
    end.join

    raw(html)
  end

  def render_flash_message(msg_type, message)
    type = BOOTSTRAP_FLASH_MSG[msg_type.to_sym]

    content_tag(:div, nil, class: "alert #{type} alert-dismissible", role: 'alert') do
      content_tag(:button, nil, class: 'close', data: { dismiss: 'alert' }, "aria-label" => 'Close') do
        content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
      end + message
    end
  end

  def select_nav(link_name)
    @selected_nav = capture { link_name }
  end

  def navigation_link(name, url)
    nav_class = @selected_nav == name ? 'active' : ''

    content_tag :li, class: "#{nav_class}" do
      link_to name, url
    end
  end

  def error_messages_for(record, field_name)
    return if record.blank? || record.errors[field_name].blank?

    error_messages = record.errors[field_name].collect do |error_message|
      "#{error_message.to_s}"
    end.join(', ')

    raw(content_tag :span, error_messages, class: 'help-inline text-danger')
  end

  def error_class_for(record, field_name)
    return if record.errors.blank? || record.errors[field_name.to_sym].blank?
    'has-error'
  end

end

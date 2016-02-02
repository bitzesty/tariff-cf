require 'addressable/uri'

module ApplicationHelper
  def nav_link(text, link)
    recognized = Rails.application.routes.recognize_path(link)
    if recognized[:controller] == params[:controller] &&
        recognized[:action] == params[:action]
      content_tag(:li, class: "active") do
        link_to(text, link)
      end
    else
      content_tag(:li) do
        link_to(text, link)
      end
    end
  end

  def user_link_target
    # The page the current user's name in the header should link them to
    if policy(current_user).edit?
      edit_user_path(current_user)
    else
      edit_email_or_passphrase_user_path(current_user)
    end
  end

  def flash_text_without_email_addresses(message)
    text_message = strip_tags(message)

    # redact email addresses so they aren't passed to GA
    text_message.gsub(/[\S]+@[\S]+/, '[email]')
  end

  SENSITIVE_QUERY_PARAMETERS = %w{reset_password_token invitation_token}

  def sensitive_query_parameters?
    (request.query_parameters.keys & SENSITIVE_QUERY_PARAMETERS).any?
  end

  def sanitised_fullpath
    uri = Addressable::URI.parse(request.fullpath)
    uri.query_values = uri.query_values.reject { |key, _value| SENSITIVE_QUERY_PARAMETERS.include?(key) }
    uri.to_s
  end
end

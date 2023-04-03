module ApplicationHelper
  def admin?
    current_user&.admin?
  end

  def member?
    current_user&.admin? || current_user&.member?
  end

  def authorized_link_to(name = nil, options = nil, html_options = nil, &block)
    path = name == '/' ? name : options
    return unless get_permission_for(path)

    link_to name, options, html_options, &block
  end

  private

  def get_permission_for(path)
    policy_params = Rails.application.routes.recognize_path(path)
    policy_name = policy_params[:controller]&.singularize&.to_sym
    action_name = "#{policy_params[:action]}?"
    policy(policy_name).send(action_name)
  end
end

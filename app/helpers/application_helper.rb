module ApplicationHelper
  def active_class_for_navbar(current_page)
    current_page.split('/')[1] == request.path.split('/')[1] ? 'active' : ''
  end
end

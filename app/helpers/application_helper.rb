module ApplicationHelper
  def page_title(title = '')
    base_title = '激安!!生麦酒店投'
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end

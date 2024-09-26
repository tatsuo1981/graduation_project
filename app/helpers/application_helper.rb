module ApplicationHelper
  def page_title(title = '', admin: false)
    base_title = admin ? '激安!!生麦酒店投(管理画面)' : '激安!!生麦酒店投'
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end

module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Todoアプリ"
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def achievement_rate()
    if @tasks.any?
      @complete_count.to_f / @current_user.tasks_count.to_f * 100
    else
      0
    end
  end
end

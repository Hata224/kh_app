# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    main_title = 'クラコピ'
    if page_title.empty?
      mail_title
    else
      page_title + ' | ' + main_title
    end
  end
end

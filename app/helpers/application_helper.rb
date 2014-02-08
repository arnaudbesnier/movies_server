module ApplicationHelper

  def format_date(date)
    return nil unless date
    date.strftime("%b %d, %Y")
  end

end

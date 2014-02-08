module ApplicationHelper

  def format_date(date)
    return nil unless date
    date.strftime("%b %d, %Y")
  end

  def edit_link_icon object
    span link_to(tag(:img, :src => asset_path('admin/edit.png'), :height => 15, :title => 'Edit'),
                      send("edit_admin_#{object.class.name.downcase}_path", object))
  end

end

module ApplicationHelper
  def sortable(column, title)
    if params[:search]
      content_tag :span, title
    else
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, :sort => column, :direction => direction
    end
  end
end

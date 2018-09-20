module ApplicationHelper
  def sortable(column, title = nil)
    direction = (column == params[:sort]) && (params[:direction] == "asc" ? "desc" : "asc")
    link_to title, :sort => column, :direction => direction
  end
end

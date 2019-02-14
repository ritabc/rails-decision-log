module ApplicationHelper
  def sortable(column, title)
    if params[:search] #TODO: Needs helper if_should_show_all_or_search_results
      content_tag :span, title, class: "nav-link"
    else
      # Toggle sort_direction
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      # Logic for asc/desc sort icon
      css_class = column == sort_column ? "current #{direction}" : nil

      # Add Link to sort + sorted Icon
      link_to url_for(controller: "decisions", action: "index", sort: column, direction: direction), :class => "nav-link #{css_class}" do
        concat(content_tag :span, title, style: "color: #0000EE")
        if css_class
          concat(image_tag("/assets/sort_icons/#{sort_direction}.png", alt: "#{sort_direction} icon", size: "17x17"))
        end
      end
    end
  end
end

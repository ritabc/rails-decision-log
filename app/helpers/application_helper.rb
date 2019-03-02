module ApplicationHelper

  # Returns html link to sort by column with title and sorted icon
  def sortable(column, title)
    # Toggle sort_direction
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    # Logic for asc/desc sort icon
    css_class = column == sort_column ? "current #{direction}" : nil
    link_to url_for(controller: "decisions", action: "all", sort: column, direction: direction), :class => "nav-link #{css_class}" do
      concat(content_tag :span, title, style: "color: #0000EE")
      if css_class
        concat(image_tag("/sort_icons/#{sort_direction}.png", alt: "#{sort_direction} icon", size: "17x17"))
      end
    end
  end
end

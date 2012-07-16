module ApplicationHelper
  def title
    base_title = "Criticube"
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
end

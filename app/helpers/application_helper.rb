module ApplicationHelper
  def full_title(title = '')
    filler = "Real Rails Application"
    bar =" | "
    if title.empty?
       filler
    else
      title + bar + filler
    end
  end
end

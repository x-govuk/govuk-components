module ApplicationHelper
  def example_heading(title)
    tag.h2(title, class: 'govuk-heading-l', id: title.parameterize)
  end
end

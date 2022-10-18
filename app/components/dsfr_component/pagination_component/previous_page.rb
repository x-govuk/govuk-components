class DsfrComponent::PaginationComponent::PreviousPage < DsfrComponent::PaginationComponent::AdjacentPage
  def initialize(href:, text:, label_text: nil, block_mode: true, classes: [], html_attributes: {})
    super(
      suffix: "prev",
      text: text,
      href: href,
      label_text: label_text,
      block_mode: block_mode,
      classes: classes,
      html_attributes: html_attributes
    )
  end

private

  def arrow
    tag.svg(class: "govuk-pagination__icon govuk-pagination__icon--prev", xmlns: "http://www.w3.org/2000/svg", height: "13", width: "15", focusable: "false", viewBox: "0 0 15 13", aria: { hidden: "true" }) do
      tag.path(d: "m6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z")
    end
  end
end

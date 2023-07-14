class GovukComponent::PaginationComponent::NextPage < GovukComponent::PaginationComponent::AdjacentPage
  def initialize(href:, text:, label_text: nil, block_mode: true, classes: [], html_attributes: {})
    super(
      suffix: "next",
      text: text,
      href: href,
      label_text: label_text,
      block_mode: block_mode,
      classes: classes,
      html_attributes: html_attributes
    )
  end

  def body
    return [arrow, title_span] if block_mode?

    [title_span, arrow]
  end

private

  def arrow
    tag.svg(class: "#{ brand }-pagination__icon #{ brand }-pagination__icon--next", xmlns: "http://www.w3.org/2000/svg", height: "13", width: "15", focusable: "false", viewBox: "0 0 15 13", aria: { hidden: "true" }) do
      tag.path(d: "m8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z")
    end
  end
end

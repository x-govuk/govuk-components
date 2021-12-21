class FooterComponentPreview < ViewComponent::Preview
  include DummyLinks
  include GovukLinkHelper

  # @label Footer
  #
  # The footer provides copyright, licensing and other information about your service and department.
  def footer
    render GovukComponent::FooterComponent.new
  end

  # @label Footer with meta items
  #
  # The footer provides copyright, licensing and other information about your service and department.
  # The `meta_items_title` is visually hidden and defaults to 'support links'
  def footer_with_meta_items
    render GovukComponent::FooterComponent.new(
      meta_items_title: "Helfpul links",
      meta_items: { "One" => "#", "Two" => "#", "Three" => "#", "Four" => "#" }
    )
  end

  # @label Footer with custom meta text
  #
  def footer_with_custom_meta_text
    render GovukComponent::FooterComponent.new(meta_text: "Some additional meta text.")
  end

  # @label Footer with custom meta HTML
  #
  def footer_with_custom_meta_html
    render GovukComponent::FooterComponent.new do |footer|
      footer.meta_html do
        tag.p("Some additional meta HTML")
      end
    end
  end

  # @label Footer with a custom licence text
  #
  # The licence text can be overridden if the service uses a licence other than the Open Government Licence.
  def footer_with_custom_meta_licence
    render GovukComponent::FooterComponent.new(
      meta_licence: "All content is available under some other open licence",
    )
  end

  # @label Footer with custom copyright text
  #
  # The copyright text can be overridden if crown copyright doesn't apply
  def footer_with_custom_copyright_text
    render GovukComponent::FooterComponent.new(
      copyright_text: "&copy; Some other copyright".html_safe,
      copyright_url: "#"
    )
  end
end

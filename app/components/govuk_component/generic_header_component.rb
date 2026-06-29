class GovukComponent::GenericHeaderComponent < GovukComponent::Base
  renders_one :logo
  renders_one :service_navigation, "GovukComponent::ServiceNavigationComponent"
  renders_one :phase_banner, "GovukComponent::PhaseBannerComponent"

  attr_reader :url,
              :logo_text,
              :menu_button_label,
              :header_html_attributes

  def initialize(url: nil,
                 logo_text: nil,
                 classes: [],
                 html_attributes: {},
                 header_html_attributes: {})

    @url = url
    @logo_text = logo_text
    @header_html_attributes = header_html_attributes

    super(classes:, html_attributes:)
  end

  def before_render
    if logo.blank?
      fail(ArgumentError, 'logo_text missing') if logo_text.blank?
      fail(ArgumentError, 'url missing') if url.blank?
    end
  end

private

  def default_attributes
    { class: class_names("#{brand}-generic-header") }
  end
end

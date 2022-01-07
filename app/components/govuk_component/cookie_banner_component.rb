module GovukComponent
  class CookieBannerComponent < GovukComponent::Base
    renders_many :messages, "GovukComponent::CookieBannerComponent::MessageComponent"

    attr_accessor :aria_label, :hidden, :hide_in_print

    def initialize(aria_label: "Cookie banner", hidden: false, hide_in_print: true, classes: [], html_attributes: {})
      super(classes: classes, html_attributes: html_attributes)

      @aria_label    = aria_label
      @hidden        = hidden
      @hide_in_print = hide_in_print
    end

    def call
      tag.div(class: classes, role: "region", aria: { label: aria_label }, data: { nosnippet: true }, hidden: hidden, **html_attributes) do
        safe_join(messages)
      end
    end

  private

    def default_classes
      class_names("govuk-cookie-banner", "govuk-!-display-none-print" => hide_in_print).split
    end
  end
end

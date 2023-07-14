module GovukComponent
  class CookieBannerComponent < GovukComponent::Base
    renders_many :messages, "GovukComponent::CookieBannerComponent::MessageComponent"

    attr_accessor :aria_label, :hidden, :hide_in_print

    def initialize(
      aria_label: config.default_cookie_banner_aria_label,
      hidden: false,
      hide_in_print: config.default_cookie_banner_hide_in_print,
      classes: [],
      html_attributes: {}
    )
      @aria_label    = aria_label
      @hidden        = hidden
      @hide_in_print = hide_in_print

      super(classes: classes, html_attributes: html_attributes)
    end

    def call
      tag.div(role: "region", aria: { label: aria_label }, data: { nosnippet: true }, hidden: hidden, **html_attributes) do
        safe_join(messages)
      end
    end

  private

    def default_attributes
      {
        class: class_names("#{ brand }-cookie-banner", "#{ brand }-!-display-none-print" => hide_in_print).split
      }
    end
  end
end

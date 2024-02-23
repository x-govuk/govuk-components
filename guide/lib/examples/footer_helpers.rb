module Examples
  module FooterHelpers
    def footer_normal
      <<~FOOTER
        = govuk_footer
      FOOTER
    end

    def footer_with_meta_items
      <<~FOOTER
        = govuk_footer(meta_items_title: "Helpful links", meta_items: meta_items)
      FOOTER
    end

    def footer_meta_items
      <<~FOOTER_META_ITEMS
        { meta_items: { "One" => "#", "Two" => "#", "Three" => "#", "Four" => "#" } }
      FOOTER_META_ITEMS
    end

    def footer_meta_complex_items
      <<~FOOTER_META_ITEMS
        {
          meta_items: [
            { text: "Apricot", href: "#apr", attr: { data: { controller: "item-a" } } },
            { text: "Blackberry", href: "#blb", attr: { data: { controller: "item-b" } } },
            { text: "Cherry", href: "#chy", attr: { rel: "noopener" } },
            { text: "Damson", href: "#dsn", attr: { aria: { description: "An edible subspecies of plum" } } },
          ]
        }
      FOOTER_META_ITEMS
    end

    def footer_with_custom_meta_html
      <<~FOOTER_META_HTML
        = render GovukComponent::FooterComponent.new do |footer|
          - footer.with_meta_html do
            | Built with love by
            = govuk_footer_link_to("X-GOVUK", "https://x-govuk.github.io/")
      FOOTER_META_HTML
    end

    def footer_with_custom_meta
      <<~FOOTER_META
        = render GovukComponent::FooterComponent.new do |footer|
          - footer.with_meta do
            .govuk-footer__meta-item
              p.govuk-footer__meta-custom
                | Any custom HTML can go here, all other content will be
                  replaced.
      FOOTER_META
    end

    def footer_with_custom_copyright_and_licence
      <<~FOOTER
        = govuk_footer(copyright_text: copyright_text, meta_licence: meta_licence)
      FOOTER
    end

    def footer_copyright_and_licence_arguments
      <<~FOOTER_COPYRIGHT_AND_LICENCE
        {
          copyright_text: "© Creative Commons",
          meta_licence: "This licence allows reusers to distribute, remix, adapt, and build upon the material in any medium or format, so long as attribution is given to the creator."
        }
      FOOTER_COPYRIGHT_AND_LICENCE
    end

    def footer_with_navigation
      <<~FOOTER_WITH_NAVIGATION
        = govuk_footer do |footer|
          - footer.with_navigation do
            .govuk-footer__section.govuk-grid-column-one-third
              h2.govuk-footer__heading.govuk-heading-m Section one

              ul.govuk-footer__list.govuk-footer__list--columns-2
                li == govuk_footer_link_to("First", "#")
                li == govuk_footer_link_to("Second", "#")
                li == govuk_footer_link_to("Third", "#")
                li == govuk_footer_link_to("Fourth", "#")
                li == govuk_footer_link_to("Fifth", "#")
                li == govuk_footer_link_to("Sixth", "#")

            .govuk-footer__section.govuk-grid-column-two-thirds
              h2.govuk-footer__heading.govuk-heading-m Section two

              ul.govuk-footer__list.govuk-footer__list--columns-3
                li == govuk_footer_link_to("First", "#")
                li == govuk_footer_link_to("Second", "#")
                li == govuk_footer_link_to("Third", "#")
                li == govuk_footer_link_to("Fourth", "#")
                li == govuk_footer_link_to("Fifth", "#")
                li == govuk_footer_link_to("Sixth", "#")
                li == govuk_footer_link_to("Seventh", "#")
                li == govuk_footer_link_to("Eighth", "#")
                li == govuk_footer_link_to("Ninth", "#")
                li == govuk_footer_link_to("Tenth", "#")
      FOOTER_WITH_NAVIGATION
    end
  end
end

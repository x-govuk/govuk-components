module Examples
  module FooterHelpers
    def footer_normal
      <<~FOOTER
        = govuk_footer
      FOOTER
    end

    def footer_with_meta_items
      <<~FOOTER
        = govuk_footer(meta_items_title: "Helfpul links", meta_items: meta_items)
      FOOTER
    end

    def footer_meta_items
      <<~FOOTER_META_ITEMS
        { meta_items: { "One" => "#", "Two" => "#", "Three" => "#", "Four" => "#" } }
      FOOTER_META_ITEMS
    end

    def footer_with_custom_meta_html
      <<~FOOTER_META_HTML
        = render GovukComponent::FooterComponent.new do |footer|
          - footer.meta_html do
            .govuk-footer__meta-custom class="govuk-\!-margin-top-1"
              | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam
                a porta purus. Fusce faucibus aliquam massa sed eleifend.
      FOOTER_META_HTML
    end

    def footer_with_custom_meta
      <<~FOOTER_META
        = render GovukComponent::FooterComponent.new do |footer|
          - footer.meta do
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
          meta_licence: "This license allows reusers to distribute, remix, adapt, and build upon the material in any medium or format, so long as attribution is given to the creator."
        }
      FOOTER_COPYRIGHT_AND_LICENCE
    end

    def footer_with_navigation
      <<~FOOTER_WITH_NAVIGATION
        = govuk_footer do |footer|
          - footer.navigation do
            .govuk-footer__section.govuk-grid-column-full
              h2.govuk-footer__heading.govuk-heading-m Section one

              ul.govuk-footer__list.govuk-footer__list--columns-2
                li: a.govuk-footer__link href="#"
                  | First
                li: a.govuk-footer__link href="#"
                  | Second
                li: a.govuk-footer__link href="#"
                  | Third
                li: a.govuk-footer__link href="#"
                  | Fourth
                li: a.govuk-footer__link href="#"
                  | Fifth
                li: a.govuk-footer__link href="#"
                  | Sixth
      FOOTER_WITH_NAVIGATION
    end
  end
end

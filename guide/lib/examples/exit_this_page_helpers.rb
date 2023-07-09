module Examples
  module BreadcrumbsHelpers
    def exit_this_page_normal
      <<~EXIT_THIS_PAGE
        = govuk_exit_this_page
      EXIT_THIS_PAGE
    end

    def exit_this_page_custom_link_and_text
      <<~EXIT_THIS_PAGE
        = govuk_exit_this_page(text: "Leave this page", redirect_url: "https://www.bbc.co.uk/news")
      EXIT_THIS_PAGE
    end

    def exit_this_page_custom_html
      <<~EXIT_THIS_PAGE
        = govuk_exit_this_page do
          = govuk_button_link_to("Go to Wikipedia", "https://www.wikipedia.org", secondary: true, class: %w(govuk-exit-this-page__button govuk-js-exit-this-page-button))
      EXIT_THIS_PAGE
    end

    def exit_this_page_secondary
      <<~EXIT_THIS_PAGE
        #{skip_link_instructions}

        = govuk_exit_this_page(secondary: true)
      EXIT_THIS_PAGE
    end
  end
end

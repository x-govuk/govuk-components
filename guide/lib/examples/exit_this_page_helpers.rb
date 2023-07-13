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
        = govuk_exit_this_page(redirect_url: "https://www.wikipedia.org") do
          strong Exit this page now
      EXIT_THIS_PAGE
    end

    def exit_this_page_link_helper
      <<~EXIT_THIS_PAGE
        #{skip_link_instructions}

        = govuk_exit_this_page_link
      EXIT_THIS_PAGE
    end

    def exit_this_page_with_custom_assistive_text
      <<~EXIT_THIS_PAGE
        = govuk_exit_this_page(activated_text: "Leave now", timed_out_text: "Exit has timed out", press_two_more_times_text: "Press shift twice to leave", press_one_more_time_text: "Press shift once more to leave")
      EXIT_THIS_PAGE
    end
  end
end

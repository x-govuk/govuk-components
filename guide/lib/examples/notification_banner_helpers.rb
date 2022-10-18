module Examples
  module NotificationBannerHelpers
    def notification_banner_normal
      <<~NOTIFICATION_BANNER
        = dsfr_notification_banner(title_text: "Important", text: "You have 7 days left to send your application.")
      NOTIFICATION_BANNER
    end

    def notification_banner_block
      <<~NOTIFICATION_BANNER
        = dsfr_notification_banner(title_text: "Important") do
          p
            |
              You have 7 days left to send your application. You can send it:

          ul
            li by email
            li by post
            li by courier
      NOTIFICATION_BANNER
    end

    def notification_banner_with_heading
      <<~NOTIFICATION_BANNER
        = dsfr_notification_banner(title_text: "Important") do |nb|
          - nb.heading(text: text, link_text: link_text, link_href: link_href)
      NOTIFICATION_BANNER
    end

    def notification_banner_heading_arguments
      <<~ARGS
        {
          text: "You have 7 days left to send your application.",
          link_text: "View application",
          link_href: "#"
        }
      ARGS
    end

    def notification_banner_success
      <<~NOTIFICATION_BANNER
        = dsfr_notification_banner(title_text: "Success", success: true) do |nb|
          - nb.heading(text: "Your application was successful")

          p Contact the helpdesk if you think there's a problem.
      NOTIFICATION_BANNER
    end
  end
end

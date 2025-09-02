class GovukComponent::ExitThisPageComponent < GovukComponent::Base
  include GovukLinkHelper
  include GovukVisuallyHiddenHelper

  attr_reader :text, :redirect_url, :activated_text, :timed_out_text, :press_two_more_times_text, :press_one_more_time_text

  def initialize(
    redirect_url: nil,
    href: nil,
    text: config.default_exit_this_page_text,
    activated_text: config.default_exit_this_page_activated_text,
    timed_out_text: config.default_exit_this_page_timed_out_text,
    press_two_more_times_text: config.default_exit_this_page_press_two_more_times_text,
    press_one_more_time_text: config.default_exit_this_page_press_one_more_time_text,
    classes: [],
    html_attributes: {}
  )
    fail(ArgumentError, "provide either redirect_url or href, not both") if redirect_url.present? && href.present?

    @text = text
    @redirect_url = href || redirect_url || config.default_exit_this_page_redirect_url || fail(ArgumentError, "no redirect_url provided")
    @activated_text = activated_text
    @timed_out_text = timed_out_text
    @press_two_more_times_text = press_two_more_times_text
    @press_one_more_time_text = press_one_more_time_text

    super(classes:, html_attributes:)
  end

  def call
    tag.div(exit_this_page_content, **html_attributes)
  end

private

  def exit_this_page_content
    govuk_button_link_to((content.presence || text), redirect_url, **link_attributes)
  end

  def default_attributes
    {
      class: "#{brand}-exit-this-page",
      data: {
        module: "#{brand}-exit-this-page",
        "i18n.activated" => activated_text,
        "i18n.timed-out" => timed_out_text,
        "i18n.press-two-more-times" => press_two_more_times_text,
        "i18n.press-one-more-time" => press_one_more_time_text,
      }.compact
    }
  end

  def link_attributes
    {
      warning: true,
      class: "#{brand}-exit-this-page__button #{brand}-js-exit-this-page-button"
    }
  end
end

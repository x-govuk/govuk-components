class GovukComponent::PanelComponent < GovukComponent::Base
  attr_reader :id, :title_text, :text, :heading_level, :interruption

  renders_one :title_html
  renders_many :actions, "Action"

  def initialize(title_text: nil, text: nil, interruption: false, heading_level: 1, id: nil, classes: [], html_attributes: {})
    @heading_level = heading_level
    @title_text    = title_text
    @text          = text
    @id            = id
    @interruption  = interruption

    super(classes:, html_attributes:)
  end

private

  def default_attributes
    {
      class: "#{brand}-panel #{brand}-panel--#{mode}",
    }
  end

  def mode
    interruption ? 'interruption' : 'confirmation'
  end

  def heading_tag
    "h#{heading_level}"
  end

  def panel_content
    content || text
  end

  def title
    title_html || title_text
  end

  def panel_title
    return if title.blank?

    content_tag(heading_tag, title, class: "#{brand}-panel__title")
  end

  def panel_body
    return if panel_content.blank?

    tag.div(class: "#{brand}-panel__body") do
      panel_content
    end
  end

  def render?
    title.present? || panel_content.present?
  end

  class Action < GovukComponent::Base
    include GovukLinkHelper
    include GovukVisuallyHiddenHelper

    attr_reader :text, :href, :type

    def initialize(text:, href:, type: :button, classes: [], html_attributes: {})
      @text = text
      @href = href
      @type = type

      super(classes:, html_attributes:)
    end

    def default_attributes
      {}
    end

    def call
      case type.to_sym
      when :button then govuk_button_link_to(text, href, inverse: true, **html_attributes)
      when :link then govuk_link_to(text, href, inverse: true, **html_attributes)
      else fail ArgumentError, "unrecognised type (must be :link or :button)"
      end
    end
  end
end

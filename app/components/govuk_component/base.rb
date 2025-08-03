class GovukComponent::Base < ViewComponent::Base
  using HTMLAttributesUtils

  attr_reader :html_attributes

  delegate :config, to: Govuk::Components

  def initialize(classes:, html_attributes:)
    if classes.nil?
      Rails.logger.warn("classes is nil, if no custom classes are needed omit the param")

      classes = []
    end
    # FIXME: remove first merge when we deprecate classes
    #
    # This step only needs to be here while we still accept classes:, now
    # we're using html_attributes_utils we can start to move towards
    # supporting html_attributes: { class: 'xyz' } over taking them
    # separately

    @html_attributes = default_attributes
      .deep_merge_html_attributes({ class: classes })
      .deep_merge_html_attributes(html_attributes)
      .deep_tidy_html_attributes

    super()
  end

  def brand(override = nil)
    override || config.brand_overrides.fetch(class_prefix, config.brand)
  end

  # We want the main component and the subcomponents here so
  # match on the second segment of the component class name
  def class_prefix
    # FIXME: this looks a bit dodgy...
    self.class.name.match(/\w+::\w+/).to_s
  end
end

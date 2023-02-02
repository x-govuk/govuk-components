class GovukComponent::Base < ViewComponent::Base
  using HTMLAttributesUtils

  attr_reader :html_attributes

  delegate :config, to: Govuk::Components

  def initialize(html_attributes:)
    @html_attributes = default_attributes
      .deep_merge_html_attributes(html_attributes)
      .deep_tidy_html_attributes

    super
  end
end

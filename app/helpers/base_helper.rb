module BaseHelper
  delegate :config, to: Govuk::Components

private

  def brand(override = nil)
    override || config.brand
  end
end

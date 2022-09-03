class GovukComponent::FooterComponent < GovukComponent::Base
  using HTMLAttributesUtils

  renders_one :meta_html
  renders_one :meta
  renders_one :navigation

  attr_reader :meta_items, :meta_text, :meta_items_title, :meta_licence, :copyright, :custom_container_classes

  def initialize(
    classes: [],
    container_classes: [],
    container_html_attributes: {},
    copyright_text: config.default_footer_copyright_text,
    copyright_url: config.default_footer_copyright_url,
    html_attributes: {},
    meta_items: {},
    meta_items_title: "Support links",
    meta_licence: nil,
    meta_text: config.default_footer_component_meta_text,
    meta_classes: [],
    meta_html_attributes: {}
  )
    @meta_text                        = meta_text
    @meta_items                       = build_meta_links(meta_items)
    @meta_items_title                 = meta_items_title
    @meta_licence                     = meta_licence
    @custom_meta_classes              = meta_classes
    @custom_meta_html_attributes      = meta_html_attributes
    @copyright                        = build_copyright(copyright_text, copyright_url)
    @custom_container_classes         = container_classes
    @custom_container_html_attributes = container_html_attributes

    super(classes: classes, html_attributes: html_attributes)
  end

private

  def default_attributes
    { class: %w(govuk-footer) }
  end

  def meta_content
    meta_html || meta_text
  end

  def meta_classes
    %w(govuk-footer__meta).append(@custom_meta_classes)
  end

  def meta_html_attributes
    @custom_meta_html_attributes
  end

  def container_html_attributes
    # FIXME: remove when we deprecate classes
    #
    # Once we drop classes this extra merging can be dropped along with the
    # container_classes and meta_classes args
    { class: %w(govuk-width-container) }.deep_merge_html_attributes(
      @custom_container_html_attributes.merge(class: custom_container_classes)
    )
  end

  def build_meta_links(links)
    return [] if links.blank?

    case links
    when Array
      links.map { |link| raw(link_to(link[:text], link[:href], class: %w(govuk-footer__link), **link.fetch(:attr, {}))) }
    when Hash
      links.map { |text, href| raw(link_to(text, href, class: %w(govuk-footer__link))) }
    else
      fail(ArgumentError, 'meta links must be a hash or array of hashes') unless links.is_a?(Hash)
    end
  end

  def default_licence
    link = link_to("Open Government Licence v3.0", "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/", class: %w(govuk-footer__link))

    raw(%(All content is available under the #{link}, except where otherwise stated))
  end

  def build_copyright(text, url)
    link_to(text, url, class: %w(govuk-footer__link govuk-footer__copyright-logo))
  end
end

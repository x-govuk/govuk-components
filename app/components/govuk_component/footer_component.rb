class GovukComponent::FooterComponent < GovukComponent::Base
  using HTMLAttributesUtils

  renders_one :meta_html
  renders_one :meta
  renders_one :navigation
  renders_one :content_before_meta_items
  renders_one :content_after_meta_items
  renders_one :meta_licence_html

  attr_reader :meta_items, :meta_text, :meta_items_title, :meta_licence, :copyright_text, :copyright_url, :custom_container_classes

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
    @raw_meta_items                   = meta_items
    @meta_items_title                 = meta_items_title
    @meta_licence                     = meta_licence
    @custom_meta_classes              = meta_classes
    @custom_meta_html_attributes      = meta_html_attributes
    @copyright_text                   = copyright_text
    @copyright_url                    = copyright_url
    @custom_container_classes         = container_classes
    @custom_container_html_attributes = container_html_attributes

    unless meta_items.blank? || meta_items.is_a?(Hash) || meta_items.is_a?(Array)
      raise ArgumentError, 'meta links must be a hash or array of hashes'
    end

    super(classes:, html_attributes:)
  end

  def before_render
    super
    @meta_items = build_meta_links(@raw_meta_items)
  end

private

  def default_attributes
    { class: "#{brand}-footer" }
  end

  def meta_content
    meta_html || meta_text
  end

  def meta_licence_content
    meta_licence_html || meta_licence
  end

  def meta_classes
    ["#{brand}-footer__meta"].append(@custom_meta_classes)
  end

  def meta_html_attributes
    @custom_meta_html_attributes
  end

  def container_html_attributes
    # FIXME: remove when we deprecate classes
    #
    # Once we drop classes this extra merging can be dropped along with the
    # container_classes and meta_classes args
    { class: "#{brand}-width-container" }.deep_merge_html_attributes(
      @custom_container_html_attributes.merge(class: custom_container_classes)
    )
  end

  def build_meta_links(links)
    return [] if links.blank?

    case links
    when Array
      links.map { |link| helpers.govuk_footer_link_to(link[:text], link[:href], **link.fetch(:attr, {})) }
    when Hash
      links.map { |text, href| helpers.govuk_footer_link_to(text, href) }
    else
      raise ArgumentError, 'meta links must be a hash or array of hashes'
    end
  end

  def default_licence
    link = link_to("Open Government Licence v3.0", "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/", class: "#{brand}-footer__link")

    raw(%(All content is available under the #{link}, except where otherwise stated))
  end

  def copyright
    link_to(copyright_text, copyright_url, class: "#{brand}-footer__link #{brand}-footer__copyright-logo")
  end
end

class BreadcrumbsComponentPreview < ViewComponent::Preview
  include DummyLinks
  include GovukLinkHelper

  # @label Basic breadcrumbs
  #
  # The breadcrumbs component helps users to understand where they are within a
  # website’s structure and move between levels.
  def breadcrumbs
    render GovukComponent::BreadcrumbsComponent.new(breadcrumbs: {
      'Level one'   => '/level-one/',
      'Level two'   => '/level-one/level-two/',
      'Level three' => '/level-one/level-two/level-three'
    })
  end

  # @label Breadcrumbs where last item isn't a link
  #
  # To make a breadcrumb display text instead of a link, pass in a nil href
  def breadcrumbs_without_hyperlink
    render GovukComponent::BreadcrumbsComponent.new(breadcrumbs: {
      'Level one'   => '/level-one/',
      'Level two'   => '/level-one/level-two/',
      'Level three' => nil
    })
  end

  # @label Breadcrumbs from an array of custom links
  #
  # For additional flexibility, instead of passing in a hash of text and links we can supply
  # an array of links.
  def breadcrumbs_from_array_of_links
    render GovukComponent::BreadcrumbsComponent.new(breadcrumbs: [
      govuk_breadcrumb_link_to('Level one', '/level-one/'),
      govuk_breadcrumb_link_to('Level two', '/level-one/level-two/'),
      govuk_breadcrumb_link_to('Level three', '/level-one/level-two/level-three/'),
    ])
  end

  # @label Breadcrumbs that will collapse on mobile
  #
  # If you have long breadcrumbs you can configure the component to only show
  # the first and last items on mobile devices.
  def breadcrumbs_that_collapse_on_mobile
    render GovukComponent::BreadcrumbsComponent.new(collapse_on_mobile: true, breadcrumbs: {
      'Level one'   => '/level-one/',
      'Level two'   => '/level-one/level-two/',
      'Level three' => '/level-one/level-two/level-three',
      'Level four' => '/level-one/level-two/level-three/level-four',
      'Level five' => '/level-one/level-two/level-three/level-four/level-five',
    })
  end

  # @label Breadcrumbs that are hidden in print
  #
  # Prevent breadcrumbs from being rendered when printing the page
  def breadcrumbs_that_are_hidden_in_print
    render GovukComponent::BreadcrumbsComponent.new(hide_in_print: true, breadcrumbs: {
      'Level one'   => '/level-one/',
      'Level two'   => '/level-one/level-two/',
      'Level three' => '/level-one/level-two/level-three'
    })
  end
end

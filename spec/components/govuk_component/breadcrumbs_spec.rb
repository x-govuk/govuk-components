require 'spec_helper'

RSpec.describe(GovukComponent::Breadcrumbs, type: :component) do
  let(:breadcrumbs) do
    {
      "Home"                 => "/level-one",
      "Products"             => "/level-two",
      "Lighting"             => "/level-three",
      "Anglepoise Desk Lamp" => nil
    }
  end
  let(:component) { GovukComponent::Breadcrumbs.new(breadcrumbs: breadcrumbs) }
  subject { Capybara::Node::Simple.new(render_inline(component).to_html) }

  specify 'contains correctly-rendered breadcrumbs' do
    expect(subject).to have_css('ol', class: 'govuk-breadcrumbs__list') do
      expect(page).to have_css('li', class: 'govuk-breadcrumbs__list-item', count: 4)

      expect(page).to have_css('li > a', class: 'govuk-breadcrumbs__link', count: 3)

      breadcrumbs
        .reject { |_, link| link.nil? }
        .each { |text, link| expect(page).to have_link(text, href: link) }

      expect(page).to have_css('li', text: 'Anglepoise Desk Lamp')
      expect(page).to_not have_link('Anglepoise Desk Lamp')
    end
  end
end

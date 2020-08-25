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

  let(:kwargs) { { breadcrumbs: breadcrumbs } }

  subject! { render_inline(GovukComponent::Breadcrumbs.new(**kwargs)) }

  specify 'contains correctly-rendered breadcrumbs' do
    expect(page).to have_css('ol', class: 'govuk-breadcrumbs__list') do |list|
      expect(list).to have_css('li', class: 'govuk-breadcrumbs__list-item', count: 4)

      expect(list).to have_css('li > a', class: 'govuk-breadcrumbs__link', count: 3)

      breadcrumbs
        .reject { |_, link| link.nil? }
        .each { |text, link| expect(list).to have_link(text, href: link) }

      expect(list).to have_css('li', text: 'Anglepoise Desk Lamp')
      expect(list).to_not have_link('Anglepoise Desk Lamp')
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

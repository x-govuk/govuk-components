require 'spec_helper'

RSpec.describe(DsfrComponent::BreadcrumbsComponent, type: :component) do
  let(:breadcrumbs) do
    {
      "Home"                 => "/level-one",
      "Products"             => "/level-two",
      "Lighting"             => "/level-three",
      "Anglepoise Desk Lamp" => nil
    }
  end

  let(:kwargs) { { breadcrumbs: breadcrumbs } }

  let(:component_css_class) { 'govuk-breadcrumbs' }

  subject! { render_inline(DsfrComponent::BreadcrumbsComponent.new(**kwargs)) }

  specify 'renders a div element containing an ordered list of breadcrumbs' do
    expect(rendered_content).to have_tag('div', with: { class: component_css_class }) do
      with_tag('ol', with: { class: 'govuk-breadcrumbs__list' }) do
        with_tag('li', with: { class: 'govuk-breadcrumbs__list-item' }, count: 4)
      end
    end
  end

  context 'when an array is provided instead of a hash' do
    let(:breadcrumbs) { %w(one two three four five) }

    specify 'renders the array items in the breadcrumbs list' do
      expect(rendered_content).to have_tag('div', with: { class: component_css_class }) do
        with_tag('ol', with: { class: 'govuk-breadcrumbs__list' }) do
          with_tag('li', with: { class: 'govuk-breadcrumbs__list-item' }, count: breadcrumbs.size)

          breadcrumbs.each do |bc|
            with_tag('li', with: { class: 'govuk-breadcrumbs__list-item' }, text: bc)
          end
        end
      end
    end
  end

  context 'when an invalid breadcrumbs object is provided' do
    specify "raises an error" do
      expect { DsfrComponent::BreadcrumbsComponent.new(breadcrumbs: "invalid") }.to raise_error(ArgumentError, "breadcrumbs must be an array or hash")
    end
  end

  specify 'breadcrumbs links are correct' do
    breadcrumbs.reject { |_, path| path.nil? }.each do |name, path|
      expect(rendered_content).to have_tag('li > a', with: { class: 'govuk-breadcrumbs__link', href: path }, text: name)
    end
  end

  specify %(breadcrumbs with no path aren't links) do
    breadcrumbs.select { |_, path| path.nil? }.each_key do |name|
      expect(rendered_content).to have_tag('li', text: name)
      expect(rendered_content).not_to have_tag('a', text: name)
    end
  end

  context 'when hide_in_print is enabled' do
    let(:kwargs) { { breadcrumbs: breadcrumbs, hide_in_print: true } }
    let(:expected_class) { 'govuk-breadcrumbs.govuk-\!-display-none-print' }

    specify 'breadcrumbs are suppressed when printing' do
      expect(rendered_content).to have_tag('div', with: { class: expected_class })
    end
  end

  context 'when collapse_on_mobile is true' do
    let(:kwargs) { { breadcrumbs: breadcrumbs, collapse_on_mobile: true } }
    let(:expected_class) { 'govuk-breadcrumbs.govuk-\!-display-none-print' }

    specify 'breadcrumbs are collapsed on mobile' do
      expect(rendered_content).to have_tag('div', with: { class: %w(govuk-breadcrumbs govuk-breadcrumbs--collapse-on-mobile) })
    end
  end

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
end

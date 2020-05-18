require 'spec_helper'

RSpec.describe(GovukComponent::Header, type: :component) do
  let(:logo) { 'OMG.UK' }
  let(:logo_href) { 'https://omg.uk/bbq' }
  let(:service_name) { 'Amazing service 1' }
  let(:service_name_href) { 'https://omg.uk/bbq/amazing-service-1/home' }
  let(:default_args) do
    {
      logo: logo,
      logo_href: logo_href,
      service_name: service_name,
      service_name_href: service_name_href
    }
  end

  subject do
    Capybara::Node::Simple.new(render_inline(component).to_html)
  end

  context 'when only the logo and service are specified' do
    let(:component) { GovukComponent::Header.new(**default_args) }

    specify 'outputs a header with correct logo and service name' do
      expect(subject).to have_css('.govuk-header') do
        expect(page).to have_css('span', class: 'govuk-header__logotype-text', text: logo)
        expect(page).to have_css('.govuk-header__content') do
          expect(page).to have_link(service_name, href: service_name_href, class: %w(govuk-header__link govuk-header__link--service-name))
        end
      end
    end

    context 'when no service name is present' do
      let(:component) { GovukComponent::Header.new(**default_args.except(:service_name)) }

      specify 'no service name related markup should be present' do
        expect(subject).not_to have_css('.govuk-header__link--service-name')
      end
    end
  end

  xcontext 'when a navigation menu is supplied' do
    specify 'the navigation block should be present in the output'
  end
end

require 'spec_helper'

RSpec.describe(GovukComponent::GenericHeaderComponent, type: :component) do
  let(:component_css_class) { 'govuk-generic-header' }
  let(:header_html_attributes) { {} }
  let(:url) { "https://a-very-nice-website.example.org.uk" }
  let(:logo_text) { "A very nice website" }

  let(:logo_selector) do
    %w[header
       div.govuk-generic-header
       div.govuk-generic-header__container
       div.govuk-generic-header__logo].join(' > ')
  end

  let(:kwargs) { { url:, logo_text:, header_html_attributes: } }

  subject! { render_inline(GovukComponent::GenericHeaderComponent.new(**kwargs)) }

  it_behaves_like 'a component that accepts custom classes'
  it_behaves_like 'a component that accepts custom HTML attributes'
  it_behaves_like 'a component that supports custom branding'
  it_behaves_like 'a component that supports brand overrides'

  specify 'builds the header with the given link' do
    expect(rendered_content).to have_tag(logo_selector) do
      with_tag('a', with: { href: url }, text: logo_text)
    end
  end

  context 'when header html attributes are provided' do
    let(:header_html_attributes) { { class: 'header-yellow', lang: 'fi' } }

    specify 'the outer header element has the custom attributes' do
      expect(rendered_content).to have_tag('header', with: { class: 'header-yellow', lang: 'fi' })
    end
  end

  context 'when a custom logo is provided' do
    let(:logo_text) { '' }
    let(:custom_logo) { %(<span class="custom-logo">Custom logo</span>) }

    subject! do
      render_inline(GovukComponent::GenericHeaderComponent.new(**kwargs)) do |header|
        header.with_logo { custom_logo.html_safe }
      end
    end

    specify 'renders the logo' do
      expect(rendered_content).to have_tag(logo_selector) do
        with_tag('span', with: { class: 'custom-logo' }, text: 'Custom logo')
      end
    end
  end

  context 'when no logo or url is supplied' do
    specify 'an argument error is thrown' do
      failing_component = GovukComponent::GenericHeaderComponent.new(url: '', logo_text: 'test')

      expect { render_inline(failing_component) }.to raise_error(ArgumentError, /url missing/)
    end
  end

  context 'when neither a logo or logo_text is supplied' do
    specify 'an argument error is thrown' do
      failing_component = GovukComponent::GenericHeaderComponent.new(logo_text: '')

      expect { render_inline(failing_component) }.to raise_error(ArgumentError, /logo_text missing/)
    end
  end

  describe 'rendering service navigation within the header' do
    subject! do
      render_inline(GovukComponent::GenericHeaderComponent.new(**kwargs)) do |header|
        header.with_service_navigation(service_name: "My new service", service_url: "#")
      end
    end

    specify 'the service navigation component is rendered within the header element' do
      expect(rendered_content).to have_tag('header') do
        with_tag('section', with: { class: 'govuk-service-navigation' }) do
          with_tag('a', text: 'My new service', href: '#')
        end
      end
    end
  end

  describe 'rendering phase banner within the header' do
    subject! do
      render_inline(GovukComponent::GenericHeaderComponent.new(**kwargs)) do |header|
        header.with_phase_banner(tag: { text: 'Alpha' }, text: 'This is a brand new service')
      end
    end

    specify 'the service navigation component is rendered within the header element' do
      expect(rendered_content).to have_tag('header') do
        with_tag('div', with: { class: 'govuk-phase-banner' }) do
          with_tag('strong', text: 'Alpha')
          with_text('This is a brand new service')
        end
      end
    end
  end

  describe 'rendering arbitrary content within the header' do
    subject! do
      render_inline(GovukComponent::GenericHeaderComponent.new(**kwargs)) do
        '<nav>Navigation goes here</nav>'.html_safe
      end
    end

    specify 'the service navigation component is rendered within the header element' do
      expect(rendered_content).to have_tag('header') do
        with_tag('div', with: { class: 'govuk-generic-header' }) do
          with_tag('nav', text: 'Navigation goes here')
        end
      end
    end
  end
end

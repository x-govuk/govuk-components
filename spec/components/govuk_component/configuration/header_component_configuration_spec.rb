require 'spec_helper'

RSpec.describe(GovukComponent::HeaderComponent, type: :component) do
  let(:kwargs) { {} }

  describe 'configuration' do
    after { Govuk::Components.reset! }

    let(:component_with_a_nav_item) do
      render_inline(GovukComponent::HeaderComponent.new) do |header|
        header.navigation_item(text: "one")
      end
    end

    describe 'default_header_component_navigation_label' do
      let(:overridden_navigation_label) { "New nav label" }

      before do
        Govuk::Components.configure do |config|
          config.default_header_component_navigation_label = overridden_navigation_label
        end
      end

      subject! { component_with_a_nav_item }

      specify "renders nav with overridden aria label" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-header__content" }) do
          with_tag("nav", with: { "aria-label" => overridden_navigation_label })
        end
      end
    end

    describe 'default_header_component_menu_button_label' do
      let(:overriddden_menu_button_label) { 'Toggle menu' }

      before do
        Govuk::Components.configure do |config|
          config.default_header_component_menu_button_label = overriddden_menu_button_label
        end
      end

      subject! { component_with_a_nav_item }

      specify "renders nav button with overridden aria label" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-header__content" }) do
          with_tag("button", with: { "aria-label" => overriddden_menu_button_label })
        end
      end
    end

    describe 'default_header_component_logotype' do
      let(:overridden_logotype) { 'DfE' }

      before do
        Govuk::Components.configure do |config|
          config.default_header_component_logotype = overridden_logotype
        end
      end

      subject! { component_with_a_nav_item }

      specify "renders header with overridden logotype" do
        expect(rendered_content).to have_tag("span", with: { class: "govuk-header__logotype" }) do
          with_tag("span", text: overridden_logotype, with: { class: "govuk-header__logotype-text" })
        end
      end
    end

    describe 'default_header_component_homepage_url' do
      let(:overriddden_homepage_url) { "/some-page" }

      before do
        Govuk::Components.configure do |config|
          config.default_header_component_homepage_url = overriddden_homepage_url
        end
      end

      subject! { component_with_a_nav_item }

      specify "renders header with overridden homepage url" do
        expect(rendered_content).to have_tag("a", {
          with: { href: overriddden_homepage_url, class: "govuk-header__link--homepage" }
        })
      end
    end

    describe 'default_header_component_service_name and default_header_component_service_url' do
      let(:current_page) { "/item-3" }

      let(:overridden_service_name) { "A new service" }
      let(:overridden_service_url) { "https://wwww.new-service.org" }

      before do
        Govuk::Components.configure do |config|
          config.default_header_component_service_name = overridden_service_name
          config.default_header_component_service_url = overridden_service_url
        end
      end

      subject! { component_with_a_nav_item }

      specify "renders header with overridden service name and url" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-header__content" }) do
          with_tag("a", href: overridden_service_url, text: overridden_service_name)
        end
      end
    end
  end
end

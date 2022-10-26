require 'spec_helper'

RSpec.describe(DsfrComponent::NotificationBannerComponent, type: :component) do
  let(:kwargs) { { title_text: "Title text", text: "Test" } }

  describe 'configuration' do
    after { Dsfr::Components.reset! }

    describe 'default_notification_banner_title_id' do
      let(:overridden_id) { "custom-title-id" }

      before do
        Dsfr::Components.configure do |config|
          config.default_notification_banner_title_id = overridden_id
        end
      end

      subject! { render_inline(DsfrComponent::NotificationBannerComponent.new(**kwargs)) }

      specify "renders the notification banner with the overridden id" do
        expect(rendered_content).to have_tag("h2", with: { id: overridden_id })
      end
    end

    describe 'default_notification_disable_auto_focus' do
      let(:overridden_auto_focus) { true }

      before do
        Dsfr::Components.configure do |config|
          config.default_notification_disable_auto_focus = overridden_auto_focus
        end
      end

      subject! { render_inline(DsfrComponent::NotificationBannerComponent.new(**kwargs)) }

      specify "adds the disable auto focus data attribute based on the default setting" do
        expect(rendered_content).to have_tag("div", with: { class: "govuk-notification-banner", "data-disable-auto-focus" => "true" })
      end
    end

    describe 'default_notification_title_heading_level' do
      let(:overridden_heading_level) { 5 }

      before do
        Dsfr::Components.configure do |config|
          config.default_notification_title_heading_level = overridden_heading_level
        end
      end

      subject! { render_inline(DsfrComponent::NotificationBannerComponent.new(**kwargs)) }

      specify "renders the overridden heading level" do
        expect(rendered_content).to have_tag("h#{overridden_heading_level}")
      end
    end

    describe 'default_notification_title_success' do
      let(:overridden_success) { true }

      before do
        Dsfr::Components.configure do |config|
          config.default_notification_title_success = overridden_success
        end
      end

      subject! { render_inline(DsfrComponent::NotificationBannerComponent.new(**kwargs)) }

      specify "renders the notification banner with the overridden success setting" do
        expect(rendered_content).to have_tag("div", with: { class: %w(govuk-notification-banner govuk-notification-banner--success) })
      end
    end
  end
end

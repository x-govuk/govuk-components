require 'spec_helper'

RSpec.describe(GovukComponent::ExitThisPageComponent, type: :component) do
  describe 'configuration' do
    after { Govuk::Components.reset! }

    describe 'default_exit_this_page_text' do
      let(:overridden_text) { 'Leave now' }

      before do
        Govuk::Components.configure do |config|
          config.default_exit_this_page_text = overridden_text
        end
      end

      describe "component" do
        subject! { render_inline(GovukComponent::ExitThisPageComponent.new) }

        specify "renders the exit component with the custom text" do
          expect(rendered_content).to have_tag("a", text: overridden_text)
        end
      end

      describe "link" do
        specify "renders the exit link with the custom text" do
          expect(helper.govuk_exit_this_page_link).to have_tag("a", text: overridden_text)
        end
      end
    end

    describe 'default_exit_this_page_redirect_url' do
      let(:overridden_redirect_url) { 'https://www.github.com' }

      before do
        Govuk::Components.configure do |config|
          config.default_exit_this_page_redirect_url = overridden_redirect_url
        end
      end

      describe "component" do
        subject! { render_inline(GovukComponent::ExitThisPageComponent.new) }

        specify "renders the exit component with the custom redirect url" do
          expect(rendered_content).to have_tag("a", with: { href: overridden_redirect_url })
        end
      end

      describe "link" do
        specify "renders the exit link with the custom redirect url" do
          expect(helper.govuk_exit_this_page_link).to have_tag("a", with: { href: overridden_redirect_url })
        end
      end
    end

    describe "announcements" do
      let(:element) { html.at('div.govuk-exit-this-page') }

      describe "default_exit_this_page_activated_text" do
        let(:overridden_activated_text) { 'Exiting the page immediately' }

        before do
          Govuk::Components.configure do |config|
            config.default_exit_this_page_activated_text = overridden_activated_text
          end
        end

        subject! { render_inline(GovukComponent::ExitThisPageComponent.new) }

        specify "adds the overridden i18n data attribute for activated text" do
          expect(element.attributes["data-i18n.activated"].value).to eql(overridden_activated_text)
        end
      end

      describe "default_exit_this_page_timed_out_text" do
        let(:overridden_timed_out_text) { 'Exit this page just expired.' }

        before do
          Govuk::Components.configure do |config|
            config.default_exit_this_page_timed_out_text = overridden_timed_out_text
          end
        end

        subject! { render_inline(GovukComponent::ExitThisPageComponent.new) }

        specify "adds the overridden i18n data attribute for activated text" do
          expect(element.attributes["data-i18n.timed-out"].value).to eql(overridden_timed_out_text)
        end
      end

      describe "default_exit_this_page_press_two_more_times_text" do
        let(:overridden_press_two_more_times_text) { 'Press me two more times to leave.' }

        before do
          Govuk::Components.configure do |config|
            config.default_exit_this_page_press_two_more_times_text = overridden_press_two_more_times_text
          end
        end

        subject! { render_inline(GovukComponent::ExitThisPageComponent.new) }

        specify "adds the overridden i18n data attribute for activated text" do
          expect(element.attributes["data-i18n.press-two-more-times"].value).to eql(overridden_press_two_more_times_text)
        end
      end

      describe "default_exit_this_page_press_one_more_time_text" do
        let(:overridden_press_one_more_time_text) { 'Press me once more to leave.' }

        before do
          Govuk::Components.configure do |config|
            config.default_exit_this_page_press_one_more_time_text = overridden_press_one_more_time_text
          end
        end

        subject! { render_inline(GovukComponent::ExitThisPageComponent.new) }

        specify "adds the overridden i18n data attribute for activated text" do
          expect(element.attributes["data-i18n.press-one-more-time"].value).to eql(overridden_press_one_more_time_text)
        end
      end
    end
  end
end

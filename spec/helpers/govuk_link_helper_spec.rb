require 'spec_helper'

INVALID_BUTTON_COMBINATIONS = [
  { warning: true, inverse: true },
  { warning: true, secondary: true },
  { secondary: true, inverse: true },
  { secondary: true, inverse: true, warning: true },
].freeze

INVALID_LINK_COMBINATIONS = [
  { text_colour: true, inverse: true },
  { muted: true, inverse: true },
  { muted: true, text_colour: true },
  { muted: true, text_colour: true, inverse: true },
].freeze

RSpec.describe(GovukLinkHelper, type: 'helper') do
  include GovukLinkHelper
  include ActionView::Helpers::UrlHelper

  before do
    allow(self).to receive(:url_for).with(any_args).and_return("/world")
  end

  describe "govuk_link_to" do
    let(:kwargs) { {} }
    subject { govuk_link_to("hello", "/world", **kwargs) }

    specify "renders a link with the correct class" do
      expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: "govuk-link" })
    end

    context "calling with a block of content" do
      subject { govuk_link_to("/world", **kwargs) { "hello" } }

      specify "renders a link with the correct class" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: "govuk-link" })
      end
    end

    context "when inverse: true" do
      let(:kwargs) { { inverse: true } }

      specify "the inverse class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: %w(govuk-link govuk-link--inverse) })
      end
    end

    context "when muted: true" do
      let(:kwargs) { { muted: true } }

      specify "the muted class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: %w(govuk-link govuk-link--muted) })
      end
    end

    context "when no_underline: true" do
      let(:kwargs) { { no_underline: true } }

      specify "the no-underline class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: %w(govuk-link govuk-link--no-underline) })
      end
    end

    context "when no_visited_state: true" do
      let(:kwargs) { { no_visited_state: true } }

      specify "the no-underline class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: %w(govuk-link govuk-link--no-visited-state) })
      end
    end

    context "when text_colour: true" do
      let(:kwargs) { { text_colour: true } }

      specify "the no-underline class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: %w(govuk-link govuk-link--text-colour) })
      end
    end

    context "when new_tab: true" do
      let(:kwargs) { { new_tab: true } }

      specify "the new tab attributes are present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: "govuk-link", target: "_blank", rel: "noreferrer noopener" })
      end
    end

    # the link modifiers text_colour, inverse, muted all change the link's text colour
    # and shouldn't be used together
    describe "invalid combinations" do
      INVALID_LINK_COMBINATIONS.each do |invalid_combination|
        context "when #{invalid_combination}" do
          let(:kwargs) { invalid_combination }

          specify "throws an error" do
            expect { subject }.to raise_error("links can be only be one of text_colour, inverse or muted")
          end
        end
      end
    end

    context "when there are custom attributes" do
      let(:kwargs) { { lang: "en-GB", dir: "ltr" } }

      specify "the custom attributes are present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: "govuk-link", lang: "en-GB", dir: "ltr" })
      end
    end
  end

  describe "govuk_mail_to" do
    let(:kwargs) { {} }
    subject { govuk_mail_to("world@solar.system", "hello", **kwargs) }

    specify "renders a link with the correct class" do
      expect(subject).to have_tag("a", text: "hello", with: { href: "mailto:world@solar.system", class: "govuk-link" })
    end

    context "calling with a block of content" do
      subject { govuk_mail_to("world@solar.system", **kwargs) { "hello" } }

      specify "renders a link with the correct class" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "mailto:world@solar.system", class: "govuk-link" })
      end
    end

    context "when inverse: true" do
      let(:kwargs) { { inverse: true } }

      specify "the inverse class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "mailto:world@solar.system", class: %w(govuk-link govuk-link--inverse) })
      end
    end

    context "when muted: true" do
      let(:kwargs) { { muted: true } }

      specify "the muted class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "mailto:world@solar.system", class: %w(govuk-link govuk-link--muted) })
      end
    end

    context "when no_underline: true" do
      let(:kwargs) { { no_underline: true } }

      specify "the no-underline class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "mailto:world@solar.system", class: %w(govuk-link govuk-link--no-underline) })
      end
    end

    context "when no_visited_state: true" do
      let(:kwargs) { { no_visited_state: true } }

      specify "the no-underline class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "mailto:world@solar.system", class: %w(govuk-link govuk-link--no-visited-state) })
      end
    end

    context "when text_colour: true" do
      let(:kwargs) { { text_colour: true } }

      specify "the no-underline class is present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "mailto:world@solar.system", class: %w(govuk-link govuk-link--text-colour) })
      end
    end

    context "when new_tab: true" do
      let(:kwargs) { { new_tab: true } }

      specify "the new tab attributes are present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "mailto:world@solar.system", class: "govuk-link", target: "_blank", rel: "noreferrer noopener" })
      end
    end

    # the link modifiers text_colour, inverse, muted all change the link's text colour
    # and shouldn't be used together
    describe "invalid combinations" do
      INVALID_LINK_COMBINATIONS.each do |invalid_combination|
        context "when #{invalid_combination}" do
          let(:kwargs) { invalid_combination }

          specify "throws an error" do
            expect { subject }.to raise_error("links can be only be one of text_colour, inverse or muted")
          end
        end
      end
    end

    context "when there are custom attributes" do
      let(:kwargs) { { lang: "en-GB", dir: "ltr" } }

      specify "the custom attributes are present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "mailto:world@solar.system", class: "govuk-link", lang: "en-GB", dir: "ltr" })
      end
    end
  end

  describe "govuk_button_link_to" do
    let(:kwargs) { {} }
    subject { govuk_button_link_to("hello", "/world", **kwargs) }

    specify "renders a link styled as a button with the correct class" do
      expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: "govuk-button" })
    end

    context "calling with a block of content" do
      subject { govuk_button_link_to("/world", **kwargs) { "hello" } }

      specify "renders a link with the correct class" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: "govuk-button" })
      end
    end

    context "when disabled: true" do
      let(:kwargs) { { disabled: true } }

      specify "the disabled class is present on the button link" do
        expect(subject).to have_tag(
          "a",
          text: "hello",
          with: {
            href: "/world",
            class: %w(govuk-button govuk-button--disabled),
            disabled: "disabled",
            "aria-disabled" => true,
          }
        )
      end
    end

    context "when inverse: true" do
      let(:kwargs) { { inverse: true } }

      specify "the inverse class is present on the button link" do
        expect(subject).to have_tag(
          "a",
          text: "hello",
          with: {
            href: "/world",
            class: %w(govuk-button govuk-button--inverse),
          }
        )
      end
    end

    context "when secondary: true" do
      let(:kwargs) { { secondary: true } }

      specify "the secondary class is present on the button link" do
        expect(subject).to have_tag(
          "a",
          text: "hello",
          with: {
            href: "/world",
            class: %w(govuk-button govuk-button--secondary),
          }
        )
      end
    end

    context "when warning: true" do
      let(:kwargs) { { warning: true } }

      specify "the warning class is present on the button link" do
        expect(subject).to have_tag(
          "a",
          text: "hello",
          with: {
            href: "/world",
            class: %w(govuk-button govuk-button--warning),
          }
        )
      end
    end

    context "when new_tab: true" do
      let(:kwargs) { { new_tab: true } }

      specify "the warning class is present on the button link" do
        expect(subject).to have_tag(
          "a",
          text: "hello",
          with: {
            href: "/world",
            class: %w(govuk-button),
            target: "_blank",
            rel: "noreferrer noopener"
          }
        )
      end
    end

    # a button can be disabled in combination with other styles but cannot
    # be called with more than one of eitehr warning, inverse or secondary
    describe "invalid combinations" do
      INVALID_BUTTON_COMBINATIONS.each do |invalid_combination|
        context "when #{invalid_combination}" do
          let(:kwargs) { invalid_combination }

          specify "throws an error" do
            expect { subject }.to raise_error("buttons can only be one of inverse, secondary or warning")
          end
        end
      end
    end

    context "when there are custom attributes" do
      let(:kwargs) { { lang: "en-GB", dir: "ltr" } }

      specify "the custom attributes are present on the link" do
        expect(subject).to have_tag("a", text: "hello", with: { href: "/world", class: "govuk-button", lang: "en-GB", dir: "ltr" })
      end
    end
  end

  describe "govuk_button_to" do
    let(:kwargs) { {} }
    subject { govuk_button_to("hello", "/world", **kwargs) }

    specify "renders a form with a button that has the right attributes and classes" do
      expect(subject).to have_tag("form", with: { method: "post", action: "/world" }) do
        with_tag("button", with: { class: "govuk-button" }, text: "hello")
      end
    end

    context "calling with a block of content" do
      subject { govuk_button_to("/world", **kwargs) { "hello" } }

      specify "renders a form with a button that has the right attributes and classes" do
        expect(subject).to have_tag("form", with: { method: "post", action: "/world" }) do
          with_tag("button", with: { class: "govuk-button" }, text: "hello")
        end
      end
    end

    context "when disabled: true" do
      let(:kwargs) { { disabled: true } }

      specify "the disabled class is present on the button" do
        expect(subject).to have_tag("form", with: { method: "post", action: "/world" }) do
          with_tag(
            "button",
            text: "hello",
            with: {
              class: %w[govuk-button govuk-button--disabled],
              disabled: "disabled",
              "aria-disabled" => true,
            }
          )
        end
      end
    end

    context "when inverse: true" do
      let(:kwargs) { { inverse: true } }

      specify "the inverse class is present on the button" do
        expect(subject).to have_tag("form", with: { method: "post", action: "/world" }) do
          with_tag(
            "button",
            text: "hello",
            with: { class: %w[govuk-button govuk-button--inverse] }
          )
        end
      end
    end

    context "when secondary: true" do
      let(:kwargs) { { secondary: true } }

      specify "the secondary class is present on the button" do
        expect(subject).to have_tag("form", with: { method: "post", action: "/world" }) do
          with_tag(
            "button",
            text: "hello",
            with: { class: %w[govuk-button govuk-button--secondary] }
          )
        end
      end
    end

    context "when warning: true" do
      let(:kwargs) { { warning: true } }

      specify "the warning class is present on the button" do
        expect(subject).to have_tag("form", with: { method: "post", action: "/world" }) do
          with_tag(
            "button",
            text: "hello",
            with: { class: %w[govuk-button govuk-button--warning] }
          )
        end
      end
    end

    # a button can be disabled in combination with other styles but cannot
    # be called with more than one of eitehr warning, inverse or secondary
    describe "invalid combinations" do
      INVALID_BUTTON_COMBINATIONS.each do |invalid_combination|
        context "when #{invalid_combination}" do
          let(:kwargs) { invalid_combination }

          specify "throws an error" do
            expect { subject }.to raise_error("buttons can only be one of inverse, secondary or warning")
          end
        end
      end
    end

    context "when there are custom attributes" do
      let(:kwargs) { { lang: "en-GB", dir: "ltr" } }

      specify "the custom attributes are present on the button" do
        expect(subject).to have_tag("form", with: { method: "post", action: "/world" }) do
          with_tag(
            "button",
            text: "hello",
            with: {
              class: %w[govuk-button],
              dir: "ltr",
              lang: "en-GB",
            }
          )
        end
      end
    end
  end
end

require 'spec_helper'

RSpec.describe(DsfrLinkHelper, type: 'helper') do
  include ActionView::Helpers::UrlHelper
  include ActionView::Context

  let(:text) { 'Menu' }
  let(:url) { '/stuff/menu/' }
  let(:args) { [text, url] }
  let(:kwargs) { {} }

  describe '#dsfr_link_classes' do
    subject { dsfr_link_classes(*args) }

    describe "by default" do
      let(:args) { [] }

      specify "contains only 'fr-link'" do
        expect(subject).to eql(%w(fr-link))
      end
    end

    {
      no_visited_state: 'fr-link--no-visited-state',
      muted:            'fr-link--muted',
      text_colour:      'fr-link--text-colour',
      inverse:          'fr-link--inverse',
      no_underline:     'fr-link--no-underline',
    }.each do |style, css_class|
      describe "generating a #{style}-style link with '#{style}: true'" do
        let(:args) { [style] }

        specify %(contains 'fr-link' and '#{css_class}') do
          expect(subject).to match_array(['fr-link', css_class])
        end
      end
    end
  end

  describe '#dsfr_button_classes' do
    subject { dsfr_button_classes(*args) }

    describe "by default" do
      let(:args) { [] }

      specify "contains only 'fr-btn'" do
        expect(subject).to eql(%w(fr-btn))
      end
    end

    {
      secondary: 'fr-btn--secondary',
      warning:   'fr-btn--warning',
      disabled:  'fr-btn--disabled',
    }.each do |style, css_class|
      describe "generating a #{style}-style button with '#{style}: true'" do
        let(:args) { [style] }

        specify %(contains 'fr-btn' and '#{css_class}') do
          expect(subject).to match_array(['fr-btn', css_class])
        end
      end
    end
  end

  describe "#dsfr_link_to" do
    let(:link_text) { 'Onwards!' }
    let(:link_url) { '/some/link' }

    before do
      allow(self).to receive(:url_for).with(link_params).and_return(link_url)
    end

    context "when provided with link text and url params" do
      let(:link_params) { { controller: :some_controller, action: :some_action } }

      subject { dsfr_link_to link_text, link_params }

      it { is_expected.to have_tag('a', text: link_text, with: { href: link_url, class: 'fr-link' }) }
    end

    context "when provided with url params and the block" do
      let(:link_html) { tag.span(link_text) }
      let(:link_params) { { controller: :some_controller, action: :some_action } }

      subject { dsfr_link_to(link_params) { link_html } }

      it { is_expected.to have_tag('a', with: { href: link_url }) { with_tag(:span, text: link_text) } }
    end

    context "customising the GOV.UK link style" do
      let(:link_params) { { controller: :some_controller, action: :some_action } }
      let(:custom_html_options) { { inverse: true } }

      subject { dsfr_link_to(link_text, link_params, custom_html_options) }

      it { is_expected.to have_tag('a', with: { href: link_url, class: "fr-link--inverse" }, text: link_text) }
    end

    context "adding custom classes" do
      let(:link_params) { { controller: :some_controller, action: :some_action } }
      let(:custom_class) { { class: "green" } }

      subject { dsfr_link_to(link_text, link_params, { class: "green", no_underline: true }) }

      it { is_expected.to have_tag('a', with: { href: link_url, class: %w(green fr-link--no-underline) }, text: link_text) }
    end
  end

  describe "#dsfr_mail_to" do
    let(:link_text) { 'Send a message' }
    let(:link_html) { tag.span(link_text) }
    let(:email_address) { 'barney@gumble.net' }
    let(:mailto_address) { "mailto:" + email_address }

    context "when email address and link text are provided via args" do
      subject { dsfr_mail_to(email_address, link_text) }

      it { is_expected.to have_tag('a', text: link_text, with: { href: mailto_address, class: 'fr-link' }) }

      context "customising the GOV.UK link style" do
        let(:custom_html_options) { { no_underline: true } }

        subject { dsfr_mail_to(email_address, link_text, custom_html_options) }

        it { is_expected.to have_tag('a', with: { href: mailto_address, class: "fr-link--no-underline" }, text: link_text) }
      end
    end

    context "when the link text is provided via an block" do
      subject { dsfr_mail_to(email_address) { link_html } }

      it { is_expected.to have_tag('a', with: { href: mailto_address }) { with_tag(:span, text: link_text) } }

      context "customising the GOV.UK link style" do
        let(:custom_html_options) { { text_colour: true } }

        subject { dsfr_mail_to(email_address, custom_html_options) { link_html } }

        it { is_expected.to have_tag('a', with: { href: mailto_address, class: "fr-link--text-colour" }) { with_tag(:span, text: link_text) } }
      end
    end

    context "adding custom classes" do
      let(:custom_class) { { class: "green" } }

      subject { dsfr_mail_to(email_address, link_text, { class: "green", no_underline: true }) }

      it { is_expected.to have_tag('a', with: { href: mailto_address, class: %w(green fr-link--no-underline) }, text: link_text) }
    end
  end

  describe "#dsfr_button_to" do
    let(:button_text) { 'Do something' }
    let(:button_url) { '/some/action' }
    let(:button_params) { { controller: :some_controller, action: :some_action } }

    before do
      allow(self).to receive(:url_for).with(anything).and_return(button_url)
    end

    context "when provided with button text and url params" do
      subject { dsfr_button_to(button_text, button_params) }

      specify "renders a form with an input of type submit and the correct attributes" do
        expect(subject).to have_tag("form", with: { class: "button_to", action: button_url }) do
          with_tag("input", with: { type: "submit", class: "fr-btn" })
        end
      end
    end

    context "when provided with url params and a block" do
      let(:button_html) { tag.span(button_text) }

      subject { dsfr_button_to(button_params) { button_html } }

      specify "renders a form with an button of type submit and the correct attributes" do
        expect(subject).to have_tag("form", with: { class: "button_to", action: button_url }) do
          with_tag("button", with: { class: "fr-btn" })
        end
      end
    end

    context "customising the GOV.UK button style" do
      let(:custom_button_options) { { secondary: true } }

      subject { dsfr_button_to(button_text, button_params, custom_button_options) }

      specify "renders a form with an button that has the GOV.UK modifier classes" do
        expect(subject).to have_tag("form", with: { class: "button_to", action: button_url }) do
          with_tag("input", with: { type: "submit", class: %w(fr-btn fr-btn--secondary) })
        end
      end
    end

    context "adding custom classes" do
      subject { dsfr_button_to(button_text, button_params, { class: "yellow", disabled: true }) }

      specify "renders a form with an button that has the custom classes" do
        expect(subject).to have_tag("form", with: { class: "button_to", action: button_url }) do
          with_tag("input", with: { type: "submit", class: %w(fr-btn yellow fr-btn--disabled) })
        end
      end
    end
  end

  describe "#dsfr_button_link_to" do
    let(:button_text) { 'Do something' }
    let(:button_url) { '/some/action' }
    let(:button_params) { { controller: :some_controller, action: :some_action } }

    before do
      allow(self).to receive(:url_for).with(button_params).and_return(button_url)
    end

    context "when provided with button text and url params" do
      subject { dsfr_button_link_to(button_text, button_params) }

      specify "renders a link styled as a button with the correct attributes" do
        expect(subject).to have_tag("a", with: {
          href: button_url,
          class: "fr-btn",
          draggable: false,
          role: "button",
          "data-module": "fr-btn"
        })
      end
    end

    context "when provided with url params and a block" do
      let(:button_html) { tag.span(button_text) }

      subject { dsfr_button_link_to(button_params) { button_html } }

      specify "renders a link styled as a button with the correct attributes" do
        expect(subject).to have_tag("a", with: { href: button_url, class: "fr-btn" }) do
          with_tag("span", text: button_text)
        end
      end
    end

    context "customising the GOV.UK button style" do
      let(:custom_button_options) { { secondary: true } }

      subject { dsfr_button_to(button_text, button_params, custom_button_options) }

      specify "renders a form with an button that has the GOV.UK modifier classes" do
        expect(subject).to have_tag("form", with: { class: "button_to", action: button_url }) do
          with_tag("input", with: { type: "submit", class: %w(fr-btn fr-btn--secondary) })
        end
      end
    end

    context "adding custom classes" do
      subject { dsfr_button_to(button_text, button_params, { class: "yellow", disabled: true }) }

      specify "renders a form with an button that has the custom classes" do
        expect(subject).to have_tag("form", with: { class: "button_to", action: button_url }) do
          with_tag("input", with: { type: "submit", class: %w(fr-btn yellow fr-btn--disabled) })
        end
      end
    end
  end

  describe "#dsfr_breadcrumb_link_to" do
    let(:breadcrumb_text) { 'Grandparent' }
    let(:breadcrumb_url) { '/several/levels/up' }

    before do
      allow(self).to receive(:url_for).with(breadcrumb_params).and_return(breadcrumb_url)
    end

    context "when provided with text and url params" do
      let(:breadcrumb_params) { { controller: :some_controller, action: :some_action } }

      subject { dsfr_breadcrumb_link_to(breadcrumb_text, breadcrumb_params) }

      it { is_expected.to have_tag('a', text: breadcrumb_text, with: { href: breadcrumb_url, class: 'govuk-breadcrumbs__link' }) }
    end

    context "when provided with url params and the block" do
      let(:breadcrumb_html) { tag.span(breadcrumb_text) }
      let(:breadcrumb_params) { { controller: :some_controller, action: :some_action } }

      subject { dsfr_breadcrumb_link_to(breadcrumb_params) { breadcrumb_html } }

      it { is_expected.to have_tag('a', with: { href: breadcrumb_url }) { with_tag(:span, text: breadcrumb_text) } }
    end

    context "adding custom classes" do
      let(:breadcrumb_params) { { controller: :some_controller, action: :some_action } }
      let(:custom_class) { "emphatic" }

      subject { dsfr_breadcrumb_link_to(breadcrumb_text, breadcrumb_params, { class: custom_class }) }

      it { is_expected.to have_tag('a', with: { href: breadcrumb_url, class: ['govuk-breadcrumbs__link', custom_class] }, text: breadcrumb_text) }
    end
  end
end

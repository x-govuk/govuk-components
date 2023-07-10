require 'spec_helper'

RSpec.describe(GovukExitThisPageLinkHelper, type: 'helper') do
  include ActionView::Helpers::UrlHelper

  let(:kwargs) { {} }
  subject { govuk_exit_this_page_link(**kwargs) }

  specify "renders an 'Exit this page' link to BBC Weather" do
    expect(subject).to have_tag("a", text: "Exit this page", with: { href: "https://www.bbc.co.uk/weather" })
  end

  specify "has the right classes" do
    expect(subject).to have_tag("a", with: { class: %w(govuk-skip-link govuk-js-exit-this-page-skiplink) })
  end

  specify "the link has the govuk-skip-link data module" do
    expect(subject).to have_tag("a", with: { "data-module" => "govuk-skip-link" })
  end

  context "when text is overridden" do
    let(:new_text) { "Leave this site" }
    let(:kwargs) { { text: new_text } }

    specify "renders link with custom text" do
      expect(subject).to have_tag("a", text: new_text, with: { href: "https://www.bbc.co.uk/weather" })
    end
  end

  context "when href is overridden" do
    let(:new_href) { "https://www.smashingmagazine.com/" }
    let(:kwargs) { { href: new_href } }

    specify "renders link with custom link target" do
      expect(subject).to have_tag("a", text: "Exit this page", with: { href: new_href })
    end
  end
end

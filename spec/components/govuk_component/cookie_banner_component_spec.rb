require "spec_helper"

RSpec.describe(GovukComponent::CookieBannerComponent, type: :component) do
  include_context 'setup'
  include_context 'helpers'

  let(:component_css_class) { 'govuk-cookie-banner' }

  let(:title) { "Cookies on a service" }
  let(:body) do
    helper.safe_join(
      [
        helper.tag.p("An introductory paragraph."),
        helper.tag.p("A second paragraph."),
      ]
    )
  end
  let(:actions) do
    helper.safe_join(
      [
        helper.button_to("Accept", "/accept-path"),
        helper.button_to("Reject", "/reject-path"),
        helper.link_to("View", "/view-path"),
      ]
    )
  end
  let(:kwargs) { { title: title } }

  subject! do
    render_inline(described_class.new(**kwargs)) do |component|
      component.body { body }
      component.actions { actions }
    end
  end

  specify "renders a cookie banner div with the right attributes" do
    expected_attributes = { class: component_css_class, role: "region", "aria-label" => "Cookie banner" }

    expect(rendered_component).to have_tag("div", with: expected_attributes) do
      with_tag("h2", with: { class: %w(govuk-cookie-banner__heading govuk-heading-m) }, text: title)
    end
  end

  specify "renders the cookie banner content" do
    expect(rendered_component).to have_tag('div', with: { class: 'govuk-cookie-banner__content' }) do
      with_tag('p', 'An introductory paragraph.')
      with_tag('p', 'A second paragraph.')
    end
  end

  specify "renders the buttons and links" do
    expect(rendered_component).to have_tag('div', with: { class: 'govuk-button-group' }) do
      with_tag('input', with: { value: 'Accept', type: 'submit' })
      with_tag('input', with: { value: 'Reject', type: 'submit' })
      with_tag('a', text: 'View', with: { href: '/view-path' })
    end
  end

  context "custom aria labels" do
    let(:aria_label) { "Cookie section" }
    let(:kwargs) { { aria_label: aria_label } }

    specify "sets the aria-label correctly" do
      expect(rendered_component).to have_tag('div', with: { class: 'govuk-cookie-banner', 'aria-label' => aria_label })
    end
  end

  context "when there is no title" do
    let(:kwargs) { {} }

    specify "renders the cookie banner without a title" do
      expect(rendered_component).to have_tag("div", with: { class: %w(govuk-cookie-banner) })
      expect(rendered_component).not_to have_tag(".govuk-cookie-banner__heading")
    end
  end

  it_behaves_like "a component that accepts custom classes"
  it_behaves_like "a component that accepts custom HTML attributes"
end

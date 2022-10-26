require "spec_helper"

RSpec.describe DsfrComponent::SectionBreakComponent, type: :component do
  let(:component_css_class) { "govuk-section-break" }
  let(:kwargs) { {} }

  it_behaves_like "a component that accepts custom classes"
  it_behaves_like "a component that accepts custom HTML attributes"

  context "when visible is true" do
    it "renders the section break with the visible class" do
      component = DsfrComponent::SectionBreakComponent.new(visible: true)

      render_inline(component)

      expect(rendered_content).to have_tag(
        "hr",
        with: { class: [component_css_class, "govuk-section-break--visible"] }
      )
    end
  end

  context "when visible is false" do
    it "renders the section break without the visible class" do
      component = DsfrComponent::SectionBreakComponent.new(visible: false)

      render_inline(component)

      expect(rendered_content).to have_tag(
        "hr",
        with: { class: [component_css_class] },
        without: { class: ["govuk-section-break--visible"] }
      )
    end
  end

  context "when size is blank" do
    it "renders the section break without the size class" do
      component = DsfrComponent::SectionBreakComponent.new

      render_inline(component)

      expect(rendered_content).to have_tag(
        "hr",
        with: { class: [component_css_class] }
      )
    end
  end

  context "when size is valid" do
    it "renders the section break with the size class" do
      component = DsfrComponent::SectionBreakComponent.new(size: "xl")

      render_inline(component)

      expect(rendered_content).to have_tag(
        "hr",
        with: { class: [component_css_class, "govuk-section-break--xl"] }
      )
    end
  end

  context "when size is invalid" do
    let(:component) { DsfrComponent::SectionBreakComponent.new(size: "s") }

    it "raises an error" do
      expect { render_inline(component) }
        .to raise_error(ArgumentError, "invalid size s, supported sizes are m, l, and xl")
    end
  end
end

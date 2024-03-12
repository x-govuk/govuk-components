require 'spec_helper'

RSpec.describe "govuk_list", type: 'helper' do
  include ActionView::Context
  include ActionView::Helpers

  context "when given an array" do
    context "with no type specified" do
      subject { govuk_list(%w[apples pears]) }

      it "generates an unordered list with no bullets" do
        expect(subject).to have_tag("ul", with: { class: "govuk-list" }) do
          with_tag("li", text: "apples")
          with_tag("li", text: "pears")
        end
      end
    end

    context "with a type of 'bullet' specified" do
      subject { govuk_list(%w[apples pears], type: 'bullet') }

      it "generates an unordered list with bullets" do
        expect(subject).to have_tag("ul", with: { class: "govuk-list govuk-list--bullet" })
      end
    end

    context "with 'spaced' specified" do
      subject { govuk_list(%w[apples pears], type: 'bullet', spaced: true) }

      it "generates an unordered list with bullets" do
        expect(subject).to have_tag("ul", with: { class: "govuk-list govuk-list--bullet govuk-list--spaced" })
      end
    end

    context "with extra classes specified as an array" do
      subject { govuk_list(%w[apples pears], type: :bullet, classes: ["app-list--squares"]) }

      it "includes the custom class" do
        expect(subject).to have_tag("ul", with: { class: "govuk-list govuk-list--bullet app-list--squares" })
      end
    end

    context "with extra class specified as a string" do
      subject { govuk_list(%w[apples pears], classes: "app-list--triangles") }

      it "includes the custom class" do
        expect(subject).to have_tag("ul", with: { class: "govuk-list app-list--triangles" })
      end
    end

    context "with a type of 'number' specified" do
      subject { govuk_list(%w[apples pears], type: 'number') }

      it "generates an ordered list with numbers" do
        expect(subject).to have_tag("ol", with: { class: "govuk-list govuk-list--number" })
      end
    end

    context "with an unrecognised type" do
      it "throws an error" do
        expect { govuk_list(%w[apples pears], type: 'random') }.to raise_error("Unrecognised type for govuk_list - should be :bullet or :number or nil")
      end
    end
  end

  context "when given a block" do
    subject { govuk_list(type: :bullet) { tag.li("apples") } }

    it "includes the govuk-list class and the content" do
      expect(subject).to have_tag("ul", class: "govuk-list govuk-list--bullet") do
        with_tag("li", text: "apples")
      end
    end
  end

  context "with extra html attributes" do
    subject { govuk_list(%w[apples], html_attributes: { id: "my-list", data: { category: 'fruit' } }) }

    specify "includes the extra attributes" do
      expect(subject).to have_tag("ul", with: { id: "my-list", class: "govuk-list", "data-category" => "fruit" })
    end
  end

  context 'when a custom brand is set' do
    around do |ex|
      Govuk::Components.configure do |conf|
        conf.brand = 'globex-corp'
      end

      ex.run

      Govuk::Components.reset!
    end

    subject { govuk_list(%w[apples], type: :bullet, spaced: true) }

    it "uses the custom brand in the class prefixes" do
      expect(subject).to have_tag("ul", with: { class: "globex-corp-list globex-corp-list--bullet globex-corp-list--spaced" })
    end
  end
end

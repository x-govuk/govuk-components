require 'spec_helper'

RSpec.describe(DsfrComponent::AlertComponent, type: :component) do
  subject! { render_inline(described_class.new(**kwargs)) { content } }

  context "alerte d'erreur" do
    let(:kwargs) { { title: "Erreur numéro 123" } }
    let(:content) { "Description de l'alerte" }

    it "affiche le titre et le contenu" do
      expect(rendered_content).to have_tag("h3", text: "Erreur numéro 123")
      expect(rendered_content).to have_tag("p", text: "Description de l'alerte")
    end
  end

  # it_behaves_like 'a component that accepts custom classes'
  # it_behaves_like 'a component that accepts custom HTML attributes'
end

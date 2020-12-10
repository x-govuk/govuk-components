shared_examples 'a component with a DSL wrapper' do
  describe 'wrapping the component', type: 'helper' do
    let(:action_view_context) { ActionView::LookupContext.new(nil) }
    let(:helper) { ActionView::Base.new(action_view_context) }

    let(:component) { helper.send(helper_name, **kwargs, &block) }
    subject { Capybara::Node::Simple.new(component) }

    specify 'renders the component' do
      expect(subject).to have_css(expected_css)
    end
  end

  describe 'wrapping slots' do
    subject { described_class.new(**kwargs, &block) }

    it { is_expected.to respond_to(:slot) }

    specify 'wraps all specified slots' do
      wrapped_slots.each do |wrapped_slot|
        is_expected.to respond_to(%(add_#{wrapped_slot}))
      end
    end
  end
end

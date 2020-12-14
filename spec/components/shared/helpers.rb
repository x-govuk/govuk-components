shared_context 'helpers' do
  let(:lookup_context) { ActionView::LookupContext.new(ActionController::Base.view_paths) }
  let(:assigns) { {} }
  let(:controller) { ActionController::Base.new }
  let(:helper) { ActionView::Base.new(lookup_context, assigns, controller) }
end

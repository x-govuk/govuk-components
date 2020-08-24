shared_context 'helpers' do
  let(:lookup_context) { ActionView::LookupContext.new(ActionController::Base.view_paths) }
  let(:helper) { ActionView::Base.new(lookup_context, {}) }
end

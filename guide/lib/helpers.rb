require 'pry'
require 'action_view'
require 'action_controller'

Dir.glob(File.join('./lib', '**', '*.rb')).sort.each { |f| require f }

use_helper Nanoc::Helpers::Rendering
use_helper Nanoc::Helpers::LinkTo
use_helper Helpers::LinkHelpers

$LOAD_PATH.unshift(File.expand_path("../../app", "app"))
$LOAD_PATH.unshift(File.expand_path("../../lib", "lib"))

require 'govuk/components'

require 'components/govuk_component'
require 'components/govuk_component/traits'
require 'components/govuk_component/traits/custom_classes'
require 'components/govuk_component/traits/custom_html_attributes'
require 'components/govuk_component/base'
require 'components/govuk_component/panel_component'

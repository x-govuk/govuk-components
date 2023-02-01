require 'pry'
require 'action_view'
require 'action_controller'
require 'htmlbeautifier'
require 'slim/erb_converter'
require 'active_support/core_ext/hash/deep_merge'
require 'active_support/core_ext/string/starts_ends_with'
require 'pagy'

Dir.glob(File.join('./lib', '**', '*.rb')).sort.each { |f| require f }

use_helper Nanoc::Helpers::Rendering
use_helper Nanoc::Helpers::LinkTo
use_helper Nanoc::Helpers::XMLSitemap
use_helper Helpers::LinkHelpers
use_helper Helpers::TitleAnchorHelpers
use_helper Helpers::Formatters
use_helper Helpers::ContentHelpers

$LOAD_PATH.unshift(File.expand_path("../../app", "app"))
$LOAD_PATH.unshift(File.expand_path("../../lib", "lib"))

require 'govuk/components'

# FIXME: Just set this to *something* to make the guide build, otherwise
#        if the view_component_path is nil we get a crash when view component
#        tries to interpolate the nil into a regexp.
#
#        The problem was started with this issue which hasn't
#        yet been solved:
#
#        https://github.com/ViewComponent/view_component/issues/1565
ViewComponent::Base.config.view_component_path = "app/components"

require 'components/govuk_component'
require 'components/govuk_component/traits'
require 'components/govuk_component/traits/custom_html_attributes'
require 'components/govuk_component/base'
require 'components/govuk_component/accordion_component'
require 'components/govuk_component/accordion_component/section_component'
require 'components/govuk_component/back_link_component'
require 'components/govuk_component/breadcrumbs_component'
require 'components/govuk_component/cookie_banner_component'
require 'components/govuk_component/cookie_banner_component/message_component'
require 'components/govuk_component/details_component'
require 'components/govuk_component/footer_component'
require 'components/govuk_component/header_component'
require 'components/govuk_component/inset_text_component'
require 'components/govuk_component/notification_banner_component'
require 'components/govuk_component/pagination_component'
require 'components/govuk_component/pagination_component/item'
require 'components/govuk_component/pagination_component/adjacent_page'
require 'components/govuk_component/pagination_component/next_page'
require 'components/govuk_component/pagination_component/previous_page'
require 'components/govuk_component/panel_component'
require 'components/govuk_component/phase_banner_component'
require 'components/govuk_component/section_break_component'
require 'components/govuk_component/start_button_component'
require 'components/govuk_component/summary_list_component'
require 'components/govuk_component/summary_list_component/key_component'
require 'components/govuk_component/summary_list_component/value_component'
require 'components/govuk_component/summary_list_component/action_component'
require 'components/govuk_component/summary_list_component/row_component'
require 'components/govuk_component/summary_list_component/card_component'
require 'components/govuk_component/table_component'
require 'components/govuk_component/table_component/cell_component'
require 'components/govuk_component/table_component/col_group_component'
require 'components/govuk_component/table_component/caption_component'
require 'components/govuk_component/table_component/head_component'
require 'components/govuk_component/table_component/body_component'
require 'components/govuk_component/table_component/row_component'
require 'components/govuk_component/table_component/foot_component'
require 'components/govuk_component/tab_component'
require 'components/govuk_component/tag_component'
require 'components/govuk_component/warning_text_component'

require 'helpers/govuk_link_helper'

use_helper GovukLinkHelper
use_helper GovukComponentsHelper
use_helper Examples::LinkHelpers
use_helper Examples::AccordionHelpers
use_helper Examples::BreadcrumbsHelpers
use_helper Examples::BackLinkHelpers
use_helper Examples::CookieBannerHelpers
use_helper Examples::DetailsHelpers
use_helper Examples::FooterHelpers
use_helper Examples::HeaderHelpers
use_helper Examples::InsetTextHelpers
use_helper Examples::NotificationBannerHelpers
use_helper Examples::PaginationHelpers
use_helper Examples::PanelHelpers
use_helper Examples::PhaseBannerHelpers
use_helper Examples::SectionBreakHelpers
use_helper Examples::SkipLinkHelpers
use_helper Examples::StartButtonHelpers
use_helper Examples::SummaryListHelpers
use_helper Examples::TableHelpers
use_helper Examples::TabsHelpers
use_helper Examples::TagHelpers
use_helper Examples::WarningTextHelpers
use_helper Examples::CommonOptionsHelpers
use_helper Examples::BackToTopLinkHelpers

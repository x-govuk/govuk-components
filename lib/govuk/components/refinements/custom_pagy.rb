module Govuk
  module Components
    module Refinements
      module CustomPagy
        refine Pagy do
          # The array of page numbers and :gap e.g. [1, :gap, 8, "9", 10, :gap, 36]
          def series(pages_around_current:)
            return [] if last < 1

            items = [*first_item, *current_items(pages_around_current), *last_item].uniq

            items.each_cons(2).with_object([]).with_index do |((a, b), arr), i|
              arr << item_value(a) if i.zero?
              arr << :gap unless a.next == b
              arr << item_value(b)
            end
          end

        private

          def item_value(number)
            number == @page ? number.to_s : number
          end

          def first_item
            [1]
          end

          def current_items(pages_around_current)
            current_page = @page || 1
            all_pages = Array(1..@last)

            before_current_upper = current_page.pred
            before_current_lower = current_page - pages_around_current

            after_current_lower = current_page.next
            after_current_upper = current_page + pages_around_current

            pages_before_current = Array(before_current_lower..before_current_upper)
            pages_after_current = Array(after_current_lower..after_current_upper)

            all_pages & [*pages_before_current, current_page, *pages_after_current]
          end

          def last_item
            [@last]
          end
        end
      end
    end
  end
end

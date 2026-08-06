module Govuk
  module Components
    module Refinements
      module CustomPagy
        refine Pagy do
          # The array of page numbers and :gap e.g. [1, :gap, 8, "9", 10, :gap, 36]
          def series
            return [] if last < 1

            items = [*first_item, *current_items, *last_item].uniq

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

          def current_items
            current_page = @page || 1

            [
              (current_page - 1 unless current_page == 1),
              current_page,
              (current_page + 1 unless current_page == @last),
            ].compact
          end

          def last_item
            [@last]
          end
        end
      end
    end
  end
end

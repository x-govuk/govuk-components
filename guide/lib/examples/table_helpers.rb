module Examples
  module TableHelpers
    def table_normal
      <<~TABLE
        = govuk_table do |table|
          - table.with_caption(size: 'm', text: 'List of Pokémon')

          - table.with_head do |head|
            - head.with_row do |row|
              - row.with_cell(text: 'Name')
              - row.with_cell(text: 'Types')
              - row.with_cell(text: 'Pokédex number', numeric: true)

          - table.with_body do |body|
            - body.with_row do |row|
              - row.with_cell(text: 'Bulbasaur')
              - row.with_cell(text: 'Grass, Poison')
              - row.with_cell(text: '1', numeric: true)

            - body.with_row do |row|
              - row.with_cell(text: 'Charmander')
              - row.with_cell(text: 'Fire')
              - row.with_cell(text: '4', numeric: true)

            - body.with_row do |row|
              - row.with_cell { 'Squirtle' }
              - row.with_cell { 'Water' }
              - row.with_cell(numeric: true) { '7' }
      TABLE
    end

    def table_with_header_column
      <<~TABLE
        = govuk_table do |table|
          - table.with_caption(size: 'm', text: 'List of Pokémon generations')

          - table.with_head do |head|
            - head.with_row do |row|
              - row.with_cell(text: 'Generation')
              - row.with_cell(text: 'Years')

          - table.with_body do |body|
            - body.with_row do |row|
              - row.with_cell(header: true, text: 'Generation 1')
              - row.with_cell(text: '1996-1999')

            - body.with_row do |row|
              - row.with_cell(header: true, text: 'Generation 2')
              - row.with_cell(text: '1999-2002')

            - body.with_row do |row|
              - row.with_cell(header: true, text: 'Generation 3')
              - row.with_cell(text: '2002-2006')

            - body.with_row do |row|
              - row.with_cell(header: true, text: 'Generation 4')
              - row.with_cell(text: '2006-2010')
      TABLE
    end

    def table_from_arrays
      <<~TABLE
        = govuk_table(caption: "Helioptile statistics", head:, rows:, foot:, first_cell_is_header: true)
      TABLE
    end

    def table_data
      <<~TABLE_DATA
        {
          head: [  "Name",          { text: "Rating", numeric: true }],
          rows: [
                  ["Health Points", { text: 44, numeric: true }],
                  ["Attack",        { text: 38, numeric: true }],
                  ["Defence",       { text: 33, numeric: true }],
                  ["Speed",         { text: 70, numeric: true }],
                ],
          foot: [  "Total",         { text: 44 + 38 + 33 + 70, numeric: true }]
        }
      TABLE_DATA
    end

    def table_with_resized_columns
      <<~TABLE
        = govuk_table do |table|
          - table.caption(size: 'm', text: 'List of Pokémon with descriptions')

          - table.with_head do |head|
            - head.with_row do |row|
              - row.with_cell(text: 'Name', width: 'one-third')
              - row.with_cell(text: 'Description')

          - table.with_body do |body|
            - body.with_row do |row|
              - row.with_cell(text: 'Blastoise')
              - row.with_cell(text: 'Blastoise is a portmanteau of "blast" and "tortoise". It is the mascot of Pokémon Blue.')

            - body.with_row do |row|
              - row.with_cell(text: 'Spearow')
              - row.with_cell(text: 'Spearows eat bugs in grassy areas and have to flap their short wings at high-speed to stay airborne.')

            - body.with_row do |row|
              - row.with_cell(text: 'Tangela')
              - row.with_cell(text: %(Blue plant vines cloak the Pokémon's identity in a tangled mass.))
      TABLE
    end

    def table_complex
      <<~TABLE
        = govuk_table(html_attributes: { class: 'starter-pokemon-weights' }) do |table|
          - table.with_caption(text: 'Starter Pokémon weights in kilograms by level, type and generation')

          - table.with_colgroup do |colgroup|
            - colgroup.with_col(span: 2)
            - colgroup.with_col(span: 3, html_attributes: { class: 'generation-1' })
            - colgroup.with_col(span: 3, html_attributes: { class: 'generation-2' })

          - table.with_head do |head|
            - head.with_row do |row|
              - row.with_cell(scope: false, html_attributes: { class: 'no-border-bottom' })
              - row.with_cell(text: 'Generation 1', colspan: 3, scope: 'colgroup', html_attributes: { class: 'generation-heading border-left' })
              - row.with_cell(text: 'Generation 2', colspan: 3, scope: 'colgroup', html_attributes: { class: 'generation-heading border-left' })

            - head.with_row do |row|
              - row.with_cell(text: 'Levels', html_attributes: { class: 'thick-border-bottom' })

              - row.with_cell(text: govuk_tag(text: 'Grass', colour: 'green'), numeric: true, html_attributes: { class: 'border-left thick-border-bottom' })
              - row.with_cell(text: govuk_tag(text: 'Fire', colour: 'red'),    numeric: true, html_attributes: { class: 'thick-border-bottom' })
              - row.with_cell(text: govuk_tag(text: 'Water', colour: 'blue'),  numeric: true, html_attributes: { class: 'thick-border-bottom' })

              - row.with_cell(text: govuk_tag(text: 'Grass', colour: 'green'), numeric: true, html_attributes: { class: 'border-left thick-border-bottom' })
              - row.with_cell(text: govuk_tag(text: 'Fire', colour: 'yellow'), numeric: true, html_attributes: { class: 'thick-border-bottom' })
              - row.with_cell(text: govuk_tag(text: 'Water', colour: 'blue'),  numeric: true, html_attributes: { class: 'thick-border-bottom' })

          - table.with_body do |body|
            - body.with_row do |row|
              - row.with_cell(header: true, text: 'Level 1-15')

              - row.with_cell(text: '6.9',   numeric: true, html_attributes: { class: 'border-left' })
              - row.with_cell(text: '8.5',   numeric: true)
              - row.with_cell(text: '9',     numeric: true)

              - row.with_cell(text: '6.5',   numeric: true, html_attributes: { class: 'border-left' })
              - row.with_cell(text: '7.9',   numeric: true)
              - row.with_cell(text: '9.5',   numeric: true)

            - body.with_row do |row|
              - row.with_cell(header: true,  text: 'Level 16-31')

              - row.with_cell(text: '13',    numeric: true, html_attributes: { class: 'border-left' })
              - row.with_cell(text: '19',    numeric: true)
              - row.with_cell(text: '22.5',  numeric: true)

              - row.with_cell(text: '15.8',  numeric: true, html_attributes: { class: 'border-left' })
              - row.with_cell(text: '19',    numeric: true)
              - row.with_cell(text: '25',    numeric: true)

            - body.with_row do |row|
              - row.with_cell(header: true,  text: 'Level 32-100')

              - row.with_cell(text: '100',   numeric: true, html_attributes: { class: 'border-left' })
              - row.with_cell(text: '90.5',  numeric: true)
              - row.with_cell(text: '85.5',  numeric: true)

              - row.with_cell(text: '100.5', numeric: true, html_attributes: { class: 'border-left' })
              - row.with_cell(text: '79.5',  numeric: true)
              - row.with_cell(text: '88.8',  numeric: true)

          - table.with_foot do |foot|
            - foot.with_row do |row|
              - row.with_cell(header: true, text: 'All levels')

              - row.with_cell(text: '#{format('%g', 6.9 + 13 + 100)}', numeric: true, html_attributes: { class: 'border-left' })
              - row.with_cell(text: '#{format('%g', 8.5 + 19 + 90.5)}', numeric: true)
              - row.with_cell(text: '#{format('%g', 9 + 22.5 + 85.5)}', numeric: true)

              - row.with_cell(text: '#{format('%g', 6.5 + 15.8 + 100.5)}', numeric: true, html_attributes: { class: 'border-left' })
              - row.with_cell(text: '#{format('%g', 7.9 + 19 + 79.5)}', numeric: true)
              - row.with_cell(text: '#{format('%g', 9.5 + 25 + 88.8)}', numeric: true)
      TABLE
    end
  end
end

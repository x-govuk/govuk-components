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
  end
end

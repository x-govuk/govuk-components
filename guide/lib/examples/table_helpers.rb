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
        = govuk_table do |table|
          - table.caption(text: "Starter Pokémon")
          - table.with_colgroup do |colgroup|
            - colgroup.with_col
            - colgroup.with_col(span: 3, html_attributes: { class: "generation-1" })
            - colgroup.with_col(span: 3, html_attributes: { class: "generation-2" })

          - table.with_head do |head|
            - head.with_row do |row|
              - row.with_cell
              - row.with_cell(text: "Generation 1", colspan: 3, scope: "colgroup")
              - row.with_cell(text: "Generation 2", colspan: 3, scope: "colgroup")
            - head.with_row do |row|
              - row.with_cell

              - row.with_cell(text: "Grass")
              - row.with_cell(text: "Fire")
              - row.with_cell(text: "Water")

              - row.with_cell(text: "Grass")
              - row.with_cell(text: "Fire")
              - row.with_cell(text: "Water")

          - table.with_body do |body|
            - body.with_row do |row|
              - row.with_cell(header: true, text: "Level 1-15")

              - row.with_cell(text: "Bulbasaur")
              - row.with_cell(text: "Charmander")
              - row.with_cell(text: "Squirtle")

              - row.with_cell(text: "Chikorita")
              - row.with_cell(text: "Cyndaquil")
              - row.with_cell(text: "Totodile")

            - body.with_row do |row|
              - row.with_cell(header: true, text: "Level 16-31")

              - row.with_cell(text: "Ivysaur")
              - row.with_cell(text: "Charmaleon")
              - row.with_cell(text: "Wartortle")

              - row.with_cell(text: "Bayleef")
              - row.with_cell(text: "Quilava")
              - row.with_cell(text: "Croconaw")

            - body.with_row do |row|
              - row.with_cell(header: true, text: "Level 32-100")

              - row.with_cell(text: "Venusaur")
              - row.with_cell(text: "Charizard")
              - row.with_cell(text: "Blastoise")

              - row.with_cell(text: "Meganium")
              - row.with_cell(text: "Typhlosion")
              - row.with_cell(text: "Feraligatr")

          - table.with_foot do |foot|
            - foot.with_row do |row|
              - row.with_cell(header: true, text: "Pokédex colour")

              - row.with_cell(text: govuk_tag(text: "Green", colour: "green"))
              - row.with_cell(text: govuk_tag(text: "Red", colour: "red"))
              - row.with_cell(text: govuk_tag(text: "Blue", colour: "blue"))

              - row.with_cell(text: govuk_tag(text: "Green", colour: "green"))
              - row.with_cell(text: govuk_tag(text: "Yellow", colour: "yellow"))
              - row.with_cell(text: govuk_tag(text: "Blue", colour: "blue"))
      TABLE
    end
  end
end

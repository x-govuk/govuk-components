module Examples
  module TableHelpers
    def table_normal
      <<~TABLE
        = govuk_table do |table|
          - table.caption(size: 'm', text: 'List of Pokémon')

          - table.head do |head|
            - head.row do |row|
              - row.cell(header: true, text: 'Name')
              - row.cell(header: true, text: 'Types')
              - row.cell(header: true, text: 'Pokédex number', numeric: true)

          - table.body do |body|
            - body.row do |row|
              - row.cell(text: 'Bulbasaur')
              - row.cell(text: 'Grass, Poison')
              - row.cell(text: '1', numeric: true)

            - body.row do |row|
              - row.cell(text: 'Charmander')
              - row.cell(text: 'Fire')
              - row.cell(text: '4', numeric: true)

            - body.row do |row|
              - row.cell(text: 'Squirtle')
              - row.cell(text: 'Water')
              - row.cell(text: '7', numeric: true)
      TABLE
    end

    def table_with_header_column
      <<~TABLE
        = govuk_table do |table|
          - table.caption(size: 'm', text: 'List of Pokémon generations')

          - table.head do |head|
            - head.row do |row|
              - row.cell(header: true, text: 'Generation')
              - row.cell(header: true, text: 'Years')

          - table.body do |body|
            - body.row do |row|
              - row.cell(header: true, text: 'Generation 1')
              - row.cell(text: '1996-1999')

            - body.row do |row|
              - row.cell(header: true, text: 'Generation 2')
              - row.cell(text: '1999-2002')

            - body.row do |row|
              - row.cell(header: true, text: 'Generation 3')
              - row.cell(text: '2002-2006')

            - body.row do |row|
              - row.cell(header: true, text: 'Generation 4')
              - row.cell(text: '2006-2010')
      TABLE
    end

    def table_from_arrays
      <<~TABLE
        = govuk_table(rows: data) { |t| t.caption { "Pokémon species and types" } }
      TABLE
    end

    def table_data
      <<~TABLE_DATA
        {
          data: [
            ["Name", "Primary type"],
            ["Weedle", "Bug"],
            ["Rattata", "Normal"],
            ["Raichu", "Electric"],
            ["Golduck", "Water"]
          ]
        }
      TABLE_DATA
    end

    def table_with_resized_columns
      <<~TABLE
        = govuk_table do |table|
          - table.caption(size: 'm', text: 'List of Pokémon with descriptions')

          - table.head do |head|
            - head.row do |row|
              - row.cell(header: true, text: 'Name', width: 'one-third')
              - row.cell(header: true, text: 'Description')

          - table.body do |body|
            - body.row do |row|
              - row.cell(text: 'Blastoise')
              - row.cell(text: 'Blastoise is a portmanteau of "blast" and "tortoise". It is the mascot of Pokémon Blue.')

            - body.row do |row|
              - row.cell(text: 'Spearow')
              - row.cell(text: 'Spearows eat bugs in grassy areas and have to flap their short wings at high-speed to stay airborne.')

            - body.row do |row|
              - row.cell(text: 'Tangela')
              - row.cell(text: %(Blue plant vines cloak the Pokémon's identity in a tangled mass.))
      TABLE
    end
  end
end

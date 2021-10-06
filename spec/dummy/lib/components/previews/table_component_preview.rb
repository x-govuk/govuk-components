class TableComponentPreview < ViewComponent::Preview
  # @label Table component
  #
  # Use the table component to make information easier to compare and scan for users.
  def table
    render GovukComponent::TableComponent.new do |table|
      table.caption { "List of Pokémon" }

      table.head do |head|
        head.row do |row|
          row.cell(header: true, text: 'Name')
          row.cell(header: true, text: 'Types')
          row.cell(header: true, text: 'Pokédex number', numeric: true)
        end
      end

      table.body do |body|
        body.row do |row|
          row.cell(text: 'Bulbasaur')
          row.cell(text: 'Grass, Poison')
          row.cell(text: '1', numeric: true)
        end
      end

      table.body do |body|
        body.row do |row|
          row.cell(text: 'Charmander')
          row.cell(text: 'Fire')
          row.cell(text: '4', numeric: true)
        end
      end

      table.body do |body|
        body.row do |row|
          row.cell(text: 'Squirtle')
          row.cell(text: 'Water')
          row.cell(text: '7', numeric: true)
        end
      end
    end
  end

  # @label Table component from an array
  #
  # Tables can also be built by passing in an array of rows, headers are configured using the head parameter
  def table_from_an_array
    render GovukComponent::TableComponent.new(
      head: %w(Pokémon Type),
      rows: [
        ['Treecko', '🌾 Grass'],
        ['Grovyle', '🌾 Grass'],
        ['Torchic', '🔥 Fire'],
        ['Mudkip', '💧 Water'],
        ['Seedot', '🌾 Grass']
      ]
    ) do |table|
      table.caption { "Pokemon type summary" }
    end
  end

  # @label Table component from an array without headers
  #
  # When no head array is provided the first row will be treated as headers
  def table_from_an_array_with_headers
    render GovukComponent::TableComponent.new(
      rows: [
        %w(Pokémon Type),
        ['Treecko', '🌾 Grass'],
        ['Grovyle', '🌾 Grass'],
        ['Torchic', '🔥 Fire'],
        ['Mudkip', '💧 Water'],
        ['Seedot', '🌾 Grass']
      ]
    ) do |table|
      table.caption { "Pokemon type summary" }
    end
  end
end

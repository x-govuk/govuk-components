require 'open3'

Nanoc::Filter.define(:dart_sass) do |_content, params|
  cmd = [%(node node_modules/sass/sass.js)].tap do |c|
    # Input file
    c << item.raw_filename

    # Load paths
    if (paths = params[:load_paths])
      paths.each do |path|
        c << %(--load-path=#{path})
      end
    end

    # Options
    params.each do |key, value|
      next if key == :load_paths

      flag = "--#{key.to_s.tr('_', '-')}"

      case value
      when true
        c << flag
      when false, nil
        next
      else
        c << "#{flag}=#{value}"
      end
    end
  end

  o, e, s = Open3.capture3(cmd.join(' '))

  fail(RuntimeError, "Failed to compile Sass", e.lines) unless s.success?

  o
end

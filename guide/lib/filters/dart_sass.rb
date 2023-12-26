require 'open3'

Nanoc::Filter.define(:dart_sass) do |content, opts|
  cmd = [%(node node_modules/sass/sass.js)].tap do |c|
    c << opts[:targets].join(' ')

    if (paths = opts[:load_paths])
      paths.each do |path|
        c << %(--load-path)
        c << path
      end
    end
  end

  o, e, s = Open3.capture3(cmd.join(' '), stdin_data: content)

  fail(RuntimeError, "Failed to compile Sass", e.lines) unless s.success?

  o
end

require 'open3'

Nanoc::Filter.define(:dart_sass) do |content, opts|
  cmd = [%(node node_modules/sass/sass.js)].tap do |c|
    c << opts[:targets].join(' ')

    if (lp = opts[:load_paths])
      c << %(--load-path)
      c << lp
    end
  end

  o, e, s = Open3.capture3(cmd.join(' '), stdin_data: content)

  fail(RuntimeError, "Failed to compile Sass", e.lines) unless s.success?

  o
end

RSpec.configure do
  RSpec::Matchers.define(:contain_svgs_with_viewBox_attributes) do
    match do |element|
      all_svgs = element.search("//xmlns:svg", "xmlns" => "http://www.w3.org/2000/svg")
      svgs_with_viewbox = element.search("//xmlns:svg[@viewBox]", "xmlns" => "http://www.w3.org/2000/svg")

      expect(all_svgs).to match_array(svgs_with_viewbox)
    end

    failure_message do |element|
      "expected #{element} to contain <svg> element with a viewBox attribute"
    end
  end
end

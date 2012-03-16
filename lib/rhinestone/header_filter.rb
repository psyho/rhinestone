module Rhinestone
  class HeaderFilter
    takes :important_headers

    def filter(headers)
      filtered = {}

      important_headers.each do |name|
        value = headers[name]
        filtered[name] = value if value
      end

      filtered
    end
  end
end

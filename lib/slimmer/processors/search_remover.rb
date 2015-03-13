module Slimmer::Processors
  class SearchRemover
    def initialize(headers)
      @headers = headers
    end

    def filter(src,dest)
      if @headers.include?(Slimmer::Headers::REMOVE_SEARCH_HEADER)
        search = dest.at_css("#global-header #search")
        search.remove if search

        search_link = dest.at_css("#global-header a[href='#search']")
        search_link.remove if search_link
      end
    end
  end
end

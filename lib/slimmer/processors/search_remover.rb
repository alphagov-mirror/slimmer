module Slimmer::Processors
  class SearchRemover
    def initialize(headers)
      @headers = headers
    end

    def filter(_src, dest)
      if @headers.include?(Slimmer::Headers::REMOVE_SEARCH_HEADER)
        search = dest.at_css("#global-header #search")
        search.remove if search

        search_link = dest.at_css("#global-header .search-toggle")
        search_link.remove if search_link

        gem_search = dest.at_css(".gem-c-layout-header__search")
        gem_search.remove if gem_search
      end
    end
  end
end

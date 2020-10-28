module Slimmer::Processors
  class AccountsShower
    def initialize(headers)
      @headers = headers
    end

    def filter(_src, dest)
      header_value = @headers[Slimmer::Headers::SHOW_ACCOUNTS_HEADER]
      if header_value == "logged-in"
        remove_logged_out(dest)
      elsif header_value == "logged-out"
        remove_logged_in(dest)
      else
        remove_logged_out(dest)
        remove_logged_in(dest)
      end
    end

    def remove_logged_out(dest)
      logged_out = dest.at_css("#global-header #accounts-logged-out")
      logged_out.remove if logged_out
    end

    def remove_logged_in(dest)
      logged_in = dest.at_css("#global-header #accounts-logged-in")
      logged_in.remove if logged_in
    end
  end
end

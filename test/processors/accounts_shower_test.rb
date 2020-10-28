require_relative "../test_helper"

class AccountsShowerTest < MiniTest::Test
  def setup
    super
    @template = as_nokogiri %(
      <html>
        <head>
        </head>
        <body>
          <div id='global-header'>
            <div id='accounts-logged-out'></div>
            <div id='accounts-logged-in'></div>
          </div>
          <div id='accounts-logged-out'></div>
          <div id='accounts-logged-in'></div>
        </body>
      </html>
    )
  end

  def test_should_remove_accounts_from_template_if_header_is_not_set
    headers = {}
    Slimmer::Processors::SearchRemover.new(
      headers,
    ).filter(nil, @template)

    assert_not_in @template, "#global-header #accounts-logged-out"
    assert_not_in @template, "#global-header #accounts-logged-in"
    assert_in @template, "#accounts-logged-out"
    assert_in @template, "#accounts-logged-in"
  end

  def test_should_remove_logged_out_from_template_if_header_is_logged_in
    headers = { Slimmer::Headers::SHOW_ACCOUNTS_HEADER => "logged-in" }
    Slimmer::Processors::SearchRemover.new(
      headers,
    ).filter(nil, @template)

    assert_not_in @template, "#global-header #accounts-logged-out"
    assert_in @template, "#global-header #accounts-logged-in"
    assert_in @template, "#accounts-logged-out"
    assert_in @template, "#accounts-logged-in"
  end

  def test_should_remove_logged_in_from_template_if_header_is_logged_out
    headers = { Slimmer::Headers::SHOW_ACCOUNTS_HEADER => "logged-out" }
    Slimmer::Processors::SearchRemover.new(
      headers,
    ).filter(nil, @template)

    assert_in @template, "#global-header #accounts-logged-out"
    assert_not_in @template, "#global-header #accounts-logged-in"
    assert_in @template, "#accounts-logged-out"
    assert_in @template, "#accounts-logged-in"
  end
end

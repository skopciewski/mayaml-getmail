require "test_helper"
require "mayaml-getmail/account_config"
require "mayaml/mail_account"

class MayamlGetmailAccountConfigTest < Minitest::Test
  def setup
    @account = ::Mayaml::MailAccount.new
    @account.name = "test"
    @account.server = "test@test.com"
    @account.user = "user"
    @account.user = "pass"
    @account.mailboxes = %w(a b)
    @generator = ::MayamlGetmail::AccountConfig.new
    @config = @generator.render(@account)
  end

  def test_that_template_has_retriever_section
    assert_match(/^\[retriever\]/, @config)
  end

  def test_that_template_has_imap_type
    assert_match(/type = SimpleIMAPSSLRetriever/, @config)
  end

  def test_that_template_has_right_server
    assert_match(/server = #{@account.server}/, @config)
  end

  def test_that_template_has_right_port
    assert_match(/port = #{@account.port}/, @config)
  end

  def test_that_template_has_right_user
    assert_match(/username = #{@account.user}/, @config)
  end

  def test_that_template_has_right_pass
    assert_match(/password = #{@account.pass}/, @config)
  end

  def test_that_template_has_default_mda_path
    assert_match(%r{path = /usr/bin/procmail}, @config)
  end

  def test_that_template_has_default_read_all
    assert_match(/read_all = true/, @config)
  end

  def test_that_template_has_default_delete
    assert_match(/delete = true/, @config)
  end

  def test_that_template_has_right_mailboxes
    assert_match(/mailboxes = \("a", "b"\)/, @config)
  end

  def test_that_template_does_not_have_mailboxes_when_empty
    @account.mailboxes = []
    @config = @generator.render(@account)
    refute_match(/mailboxes = /, @config)
  end
end

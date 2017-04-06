# frozen_string_literal: true
require "test_helper"
require "mayaml-getmail/configs_generator"
require "mayaml-getmail/account_config"
require "mayaml/mail_account"

class MayamlGetmailConfigsGeneratorTest < Minitest::Test
  def setup
    account_config = ::MayamlGetmail::AccountConfig.new
    @generator = ::MayamlGetmail::ConfigsGenerator.new(account_config)
  end

  def account(name, type = :imap)
    account = ::Mayaml::MailAccount.new
    account.name = name
    account.realname = "joe"
    account.type = type
    account.server = "test.test.com"
    account.port = 999
    account.user = "user"
    account.pass = "pass"
    account.smtp_protocol = "smtps"
    account.smtp_port = 555
    account.smtp_authenticator = "login"
    account.smtp_server = "test.test.com"
    account
  end

  def test_that_generator_generates_hash
    accounts = [account("acc1")]
    results = @generator.generates(accounts)
    assert_instance_of Hash, results
  end

  def test_that_generator_returns_hash_with_right_key
    accounts = [account("acc1")]
    results = @generator.generates(accounts)
    assert results.key?(accounts.first.name.to_sym)
  end

  def test_that_generator_returns_hash_with_pop3_config
    accounts = [account("acc1", :pop3)]
    results = @generator.generates(accounts)
    assert_match(/type = SimplePOP3Retriever/, results[:acc1])
  end

  def test_that_generator_returns_hash_with_pop3ssl_config
    accounts = [account("acc1", :pop3ssl)]
    results = @generator.generates(accounts)
    assert_match(/type = SimplePOP3SSLRetriever/, results[:acc1])
  end

  def test_that_generator_returns_hash_with_imap_config
    accounts = [account("acc1", :imap)]
    results = @generator.generates(accounts)
    assert_match(/type = SimpleIMAPRetriever/, results[:acc1])
  end

  def test_that_generator_returns_hash_with_imapssl_config
    accounts = [account("acc1", :imapssl)]
    results = @generator.generates(accounts)
    assert_match(/type = SimpleIMAPSSLRetriever/, results[:acc1])
  end

  def test_that_gernerator_generates_two_configs_for_two_accounts
    accounts = [account("acc1"), account("acc2")]
    results = @generator.generates(accounts)
    assert_equal 2, results.count
  end
end

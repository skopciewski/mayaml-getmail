require "test_helper"
require "mayaml-getmail"

class MayamlGetmailTest < Minitest::Test
  def setup
    yaml_accounts = "fake.yml"
    @configs = MayamlGetmail.configs_from_file(yaml_accounts)
  end

  def test_that_it_has_a_version_number
    refute_nil ::MayamlGetmail::VERSION
  end

  def test_that_it_returns_hash
    assert_instance_of Hash, @configs
  end

  def test_that_it_returns_empty_hash_for_fake_file
    assert_empty@configs
  end
end

# encoding: utf-8

# Copyright (C) 2016 Szymon Kopciewski
#
# This file is part of Mayaml.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "mayaml/version"
require "mayaml/mail_account/builder"
require "mayaml/parser"

module Mayaml
  def self.accounts_from_file(yaml_accounts)
    raw_accounts = Parser.get_accounts(yaml_accounts)
    raw_accounts.map do |raw_account|
      build_account(raw_account)
    end
  end

  def self.build_account(raw_account)
    MailAccount::Builder.build do |builder|
      builder.name raw_account.fetch("name")
      builder.type raw_account.fetch("type")
      builder.server raw_account.fetch("server")
      builder.port raw_account.fetch("port")
      builder.user raw_account.fetch("user")
      builder.pass raw_account.fetch("pass")
      builder.mailboxes raw_account.fetch("mailboxes", [])
    end
  end
end

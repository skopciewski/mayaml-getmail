# encoding: utf-8

# Copyright (C) 2016 Szymon Kopciewski
#
# This file is part of MayamlGetmail.
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

require "mustache"

module MayamlGetmail
  class AccountConfig
    def initialize
      @template = IO.read(File.join(File.dirname(__FILE__), "account_config.mustache"))
    end

    def render(mail_account, config = {})
      ::Mustache.render(
        @template,
        type: type(mail_account),
        server: mail_account.server,
        port: mail_account.port,
        user: mail_account.user,
        pass: mail_account.pass,
        mda_path: config.fetch(:mda_path, "/usr/bin/procmail"),
        read_all: config.fetch(:read_all, "true"),
        delete: config.fetch(:delete, "true"),
        mailboxes: mailboxes(mail_account)
      )
    end

    private

    def type(mail_account)
      types_map = {
        imap: "SimpleIMAPSSLRetriever",
        pop3: "SimplePOP3SSLRetriever"
      }
      types_map.fetch mail_account.type
    end

    def mailboxes(mail_account)
      "\"" + mail_account.mailboxes.join("\", \"") + "\"" unless mail_account.mailboxes.empty?
    end
  end
end

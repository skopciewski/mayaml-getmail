# frozen_string_literal: true

# Copyright (C) 2016, 2017, 2018 Szymon Kopciewski
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
    def render(mail_account, config = {})
      ::Mustache.render(
        IO.read(template_file_path),
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

    def template_file_path
      templates_dir = File.expand_path("../templates", __dir__)
      File.join(templates_dir, "account_config.mustache")
    end

    def type(mail_account)
      types_map = {
        imap: "SimpleIMAPRetriever",
        imapssl: "SimpleIMAPSSLRetriever",
        pop3: "SimplePOP3Retriever",
        pop3ssl: "SimplePOP3SSLRetriever"
      }
      types_map.fetch mail_account.type
    end

    def mailboxes(mail_account)
      "\"" + mail_account.mailboxes.join("\", \"") + "\"" unless mail_account.mailboxes.empty?
    end
  end
end

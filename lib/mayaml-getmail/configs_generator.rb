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

module MayamlGetmail
  class ConfigsGenerator
    def initialize(templater)
      @templater = templater
    end

    def generates(accounts)
      accounts.each_with_object({}) do |mail_account, result|
        key = mail_account.name.to_sym
        result[key] = @templater.render(mail_account)
        result
      end
    end
  end
end

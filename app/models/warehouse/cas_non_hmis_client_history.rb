###
# Copyright 2016 - 2020 Green River Data Analysis, LLC
#
# License detail: https://github.com/greenriver/boston-cas/blob/master/LICENSE.md
###

# for writing latest state of matches X decisions into HMIS database
module Warehouse
  class CasNonHmisClientHistory < Base
    self.table_name = 'cas_non_hmis_client_histories'
  end
end
###
# Copyright 2016 - 2020 Green River Data Analysis, LLC
#
# License detail: https://github.com/greenriver/boston-cas/blob/master/LICENSE.md
###

# bundle exec rails runner 'TestDatabaseMailer.with(email: "somebody@greenriver.com").ping.deliver_now'

class TestDatabaseMailer < DatabaseMailer
  default from: 'noreply@greenriver.com'

  def ping
    email = params[:email]
    mail({
      to: [email],
      subject: 'test'
    }) do |format|
      format.text { render plain: "Test #{SecureRandom.hex(6)}" }
    end
  end
end

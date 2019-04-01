module Notifications
  class CriminalHearingScheduledSsp < Base
    def self.create_for_match!(match)
      match.ssp_contacts.each do |contact|
        create! match: match, recipient: contact
      end
    end

    def event_label
      label = _('Stabilization Services Provider')
      label += ' '
      label += _('sent notice of criminal background hearing date.')
    end
  end
end

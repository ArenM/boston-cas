###
# Copyright 2016 - 2020 Green River Data Analysis, LLC
#
# License detail: https://github.com/greenriver/boston-cas/blob/master/LICENSE.md
###

class NotificationsMailer < DatabaseMailer

  private def setup_instance_variables notification
    @notification = notification
    @match = notification.match
    @contact = notification.recipient
    @decision = notification.decision
  end

  def match_recommendation_dnd_staff
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "New Housing Recommendation - Requires Your Action")
  end

  def match_recommendation_client
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "New Housing Opportunity")
  end

  def match_recommendation_housing_subsidy_admin
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "New Housing Recommendation")
  end

  def match_recommendation_ssp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "New Housing Recommendation")
  end

  def match_recommendation_hsp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "New Housing Recommendation")
  end

  def match_recommendation_shelter_agency
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "New Housing Recommendation - Requires Your Action")
  end

  def schedule_criminal_hearing_housing_subsidy_admin
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Housing Recommendation - Requires Your Action")
  end

  def schedule_criminal_hearing_ssp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Housing Recommendation")
  end

  def schedule_criminal_hearing_hsp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Housing Recommendation")
  end

  def record_client_housed_date_shelter_agency
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Housing Recommendation Approved - Requires Your Action")
  end

  def record_client_housed_date_housing_subsidy_administrator
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Housing Recommendation Approved - Requires Your Action")
  end

  def move_in_date_set
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Housing Recommendation Move-in Date Set")
  end

  def confirm_match_success_dnd_staff
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Housing Recommendation - Requires Final Approval")
  end

  def criminal_hearing_scheduled_shelter_agency
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Hearing Scheduled")
  end

  def criminal_hearing_scheduled_ssp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Hearing Scheduled")
  end

  def criminal_hearing_scheduled_hsp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Hearing Scheduled")
  end

  def criminal_hearing_scheduled_client
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Hearing Scheduled")
  end

  def criminal_hearing_scheduled_dnd_staff
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Hearing Scheduled")
  end

  def housing_subsidy_admin_decision_client
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Decision from #{_('Housing Subsidy Administrator')}")
  end

  def housing_subsidy_admin_decision_shelter_agency
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Decision from #{_('Housing Subsidy Administrator')}")
  end

  def housing_subsidy_admin_decision_ssp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Decision from #{_('Housing Subsidy Administrator')}")
  end

  def housing_subsidy_admin_decision_hsp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Decision from #{_('Housing Subsidy Administrator')}")
  end

  def housing_subsidy_admin_decision_development_officer
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Decision from #{_('Housing Subsidy Administrator')}")
  end

  def housing_subsidy_admin_accepted_match_dnd_staff
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Accepted by #{_('HSA')}")
  end

  def housing_subsidy_admin_declined_match_shelter_agency
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Declined by #{_('HSA')}")
  end

  def housing_subsidy_admin_declined_match_ssp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Declined by #{_('HSA')}")
  end

  def housing_subsidy_admin_declined_match_hsp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Declined by #{_('HSA')}")
  end

  def confirm_shelter_agency_decline_dnd_staff
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Declined by #{_('Shelter Agency')} - Requires Your Action")
  end

  def confirm_housing_subsidy_admin_decline_dnd_staff
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Declined by #{_('HSA')} - Requires Your Action")
  end

  def on_behalf_of
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Action taken on your behalf")
  end

  def no_longer_working_with_client
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Contact no longer working with Client")
  end

  def match_canceled
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Administratively Canceled")
  end

  def shelter_agency_accepted
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "#{_('Shelter Agency')} Accepted Match")
  end

  def shelter_agency_decline_accepted
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Decline Accepted")
  end

  def match_success_confirmed_development_officer
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Success Confirmed")
  end
  # End Default Route

  # Provider Only
  def match_initiation_for_hsa
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "New Housing Recommendation - Requires Your Action")
  end

  def match_initiation_for_shelter_agency
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "New Housing Recommendation")
  end

  def match_initiation_for_ssp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "New Housing Recommendation")
  end


  def hsa_accepts_client
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match ready for review - Requires Your Action")
  end

  def hsa_accepts_client_ssp_notification
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match accepted by #{_('HSA')}")
  end

  def confirm_hsa_decline_dnd_staff
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Declined by #{_('HSA')} - Requires Your Action")
  end

  def hsa_decision_client
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Decision from #{_('Housing Subsidy Administrator')}")
  end

  def hsa_decision_shelter_agency
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Decision from #{_('Housing Subsidy Administrator')}")
  end

  def hsa_decision_ssp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Decision from #{_('Housing Subsidy Administrator')}")
  end

  def hsa_decision_hsp
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Decision from #{_('Housing Subsidy Administrator')}")
  end

  # End Provider Only

  # Manual Activation

  def match_initiation_for_manual_notification
    notification = params[:notification]
    setup_instance_variables notification
    if @match.present?
      @route_name = @match.match_route.title
      mail(to: @contact.email, subject: "New matches have been added on the #{@route_name}")
    end
  end

  def housing_opportunity_successfully_filled
    notification = params[:notification]
    setup_instance_variables notification
    @route_name = @match.match_route.title
    mail(to: @contact.email, subject: 'Match Canceled - Vacancy filled by other client')
  end

  # end Manual Activation

  # Set Asides

  def set_asides_hsa_accepts_client
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match ready for review - Requires Your Action")
  end

  # end Set Asides

  # Match Route Four

  def match_recommendation_hsa
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match ready for review - Requires Your Action")
  end

  def housing_subsidy_administrator_accepted
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match accepted by #{_('HSA')}")
  end

  def confirm_hsa_initial_decline_dnd_staff
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Declined by #{_('HSA')} - Requires Your Action")
  end
  # end Match Route Four

  # Progress Updates
  def progress_update_requested
    @notifications = ::Notifications::Base.where(id: params[:notification_ids])
    @contact = @notifications.first.recipient
    mail(to: @contact.email, subject: "Match Progress Updates Requested - Requires Your Action")
  end

  def progress_update_submitted
    notification = params[:notification]
    setup_instance_variables notification
    mail(to: @contact.email, subject: "Match Progress Update Submitted")
  end

  def dnd_progress_update_late
    @notifications = ::Notifications::Base.where(id: params[:notification_ids])
    @contact = @notifications.first.recipient
    mail(to: @contact.email, subject: "Match Progress Late")
  end

  # Notes
  def note_sent
    notification = params[:notification]
    setup_instance_variables notification
    @note = params[:note]
    @include_content = notification.include_content
    mail(to: @contact.email, subject: "Note from CAS - Requires Your Action")
  end

end

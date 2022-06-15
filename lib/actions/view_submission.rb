require_relative '../helpers/display_home'

SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'view_submission' do |action|
    payload = action[:payload]

    team = Team.where(team_id: payload[:team][:id]).first || raise("Cannot find team with ID #{payload[:team][:id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)

    team.mails.create(
      from_user_id: payload[:user][:id],
      to_user_id: payload[:view][:state][:values][:user_selected][:'users_select-action'][:selected_user],
      text: payload[:view][:state][:values][:message][:content][:value]
    )
    Helpers::DisplayHome.perform(slack_client, team, payload[:user][:id])
    nil
  end
end

require_relative '../helpers/display_home'

SlackRubyBotServer::Events.configure do |config|
  config.on :event, ['event_callback', 'app_home_opened'] do |event|
    team = Team.where(team_id: event[:team_id]).first || raise("Cannot find team with ID #{event[:team_id]}.")

    slack_client = Slack::Web::Client.new(token: team.token)

    user = slack_client.users_info(user: event[:event][:user])
    user_name = user[:user][:name]
    user_id = user[:user][:id]

    event.logger.info "User #{user_name} opened home"

    Helpers::DisplayHome.perform(slack_client, team, user_id)
    { ok: true }
  end
end

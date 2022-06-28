# frozen_string_literal: true

class User < ActiveRecord::Base
  belongs_to :team

  def self.sync(slack_user_id, team)
    return if exists?(slack_id: slack_user_id, team: team)

    slack_client = Slack::Web::Client.new(token: team.token)
    create(
      slack_id: slack_user_id,
      username: slack_client.users_info(user: slack_user_id).dig(:user, :name)
    )
  end
end

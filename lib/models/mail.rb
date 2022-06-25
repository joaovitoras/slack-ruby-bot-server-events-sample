# frozen_string_literal: true

class Mail < ActiveRecord::Base
  belongs_to :team
  after_create_commit :send_message_to_user

  def send_message_to_user
    slack_client = Slack::Web::Client.new(token: team.token)
    message = "Novo correio elegante: #{text}"
    slack_client.chat_postMessage(channel: to_user_id, text: message)
    update(sent: true)
  end
end

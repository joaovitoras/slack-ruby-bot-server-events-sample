SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'block_actions', 'open_mail_modal' do |action|
    team = Team.where(team_id: action[:payload][:team][:id]).first || raise("Cannot find team with ID #{action[:payload][:team][:id]}.")
    slack_client = Slack::Web::Client.new(token: team.token)
    trigger_id = action[:payload][:trigger_id]

    modal = {
      type: 'modal',
      callback_id: 'form_submitted',
      title: {
        type: 'plain_text',
        text: 'Correio elegante'
      },
      submit: {
        type: 'plain_text',
        text: 'Enviar :heart:'
      },
      blocks: [
        {
          type: 'input',
          block_id: 'user_selected',
          element: {
            type: 'users_select',
            placeholder: {
              type: 'plain_text',
              text: 'Selecionar destinatário',
              emoji: true
            },
            action_id: 'users_select-action'
          },
          label: {
            type: 'plain_text',
            text: 'Destinatário',
            emoji: true
          }
        },
        {
          type: 'input',
          block_id: 'message',
          label: {
            type: 'plain_text',
            text: 'Mensagem'
          },
          element: {
            action_id: 'content',
            type: 'plain_text_input',
            placeholder: {
              type: 'plain_text',
              text: 'Mensagem... ',
            },
            multiline: true
          }
        }
      ]
    }

    slack_client.views_open(trigger_id: trigger_id, view: modal)
    { ok: true }
  end
end

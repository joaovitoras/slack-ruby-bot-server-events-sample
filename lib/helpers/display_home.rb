module Helpers
  class DisplayHome
    def self.perform(slack_client, team, user_id)
      mails = []
      team.mails.find_each do |mail|
        mails << [
          { type: 'divider' },
          { type: 'section', text: { type: 'mrkdwn', text: '*Correios enviados*' } },
          {
            type: 'section',
            text: {
              type: 'mrkdwn',
              text: "<@#{mail.to_user_id}>\n\n#{mail.text}"
            }
          }
          { type: 'divider' },
        ]
      end

      blocks = [
        {
          type: 'header',
          text: {
            type: 'plain_text',
            text: 'Bem vindo ao Correio Elegante Quero!'
          }
        },
        {
          type: 'actions',
          elements: [
            {
              type: 'button',
              action_id: 'open_mail_modal',
              text: {
                type: 'plain_text',
                text: ':love_letter: Novo correio elegante',
                emoji: true
              },
              style: 'primary',
              value: 'open_mail_modal'
            }
          ]
        },
        { type: 'divider' },
        { type: 'section', text: { type: 'mrkdwn', text: '*Correios enviados*' } },
        mails
      ].flatten

      view = {
        type: 'home',
        blocks: blocks
      }

      slack_client.views_publish(user_id: user_id, view: view)
    end
  end
end

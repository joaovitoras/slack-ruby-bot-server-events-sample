module Helpers
  class DisplayHome
    def self.perform(slack_client, team, user_id)
      sent_mails = []
      received_mails = []
      team.mails.where(from_user_id: user_id).find_each do |mail|
        sent_mails << [
          {
            type: 'section',
            text: {
              type: 'mrkdwn',
              text: "Para: <@#{mail.to_user_id}>\n\nMensagem: #{mail.text}"
            }
          },
          { type: 'divider' }
        ]
      end

      team.mails.where(to_user_id: user_id).find_each do |mail|
        received_mails << [
          {
            type: 'section',
            text: {
              type: 'mrkdwn',
              text: "Mensagem: #{mail.text}"
            }
          },
          { type: 'divider' }
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
      ]

      if team.active?
        blocks << {
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
        }
      end

      blocks << [
        { type: 'divider' },
        { type: 'section', text: { type: 'mrkdwn', text: '*Correios enviados*' } },
        sent_mails,
        {
          type: 'context',
          elements: [
            {
              type: 'image',
              image_url: 'https://api.slack.com/img/blocks/bkb_template_images/placeholder.png',
              alt_text: 'placeholder'
            }
          ]
        },
        { type: 'section', text: { type: 'mrkdwn', text: '*Correios Recebidos*' } },
        received_mails
      ].flatten

      view = {
        type: 'home',
        blocks: blocks
      }

      slack_client.views_publish(user_id: user_id, view: view)
    end
  end
end

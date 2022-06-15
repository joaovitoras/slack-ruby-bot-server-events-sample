# frozen_string_literal: true

class Team
  def mails
    Mail.where(team_id: self.id)
  end
end

ActiveRecord::Base.establish_connection(
  YAML.safe_load(
    ERB.new(
      File.read('config/postgresql.yml')
    ).result, [], [], true
  )[ENV.fetch('RACK_ENV', nil)]
)

db = ActiveRecord::Base.connection
db.create_table :mails, if_not_exists: true
db.add_reference :mails, :team, if_not_exists: true rescue nil
db.add_column :mails, :from_user_id, :string, if_not_exists: true
db.add_column :mails, :to_user_id, :string, if_not_exists: true
db.add_column :mails, :text, :string, if_not_exists: true
db.add_column :mails, :sent, :boolean, default: false, if_not_exists: true
db.add_timestamps :mails rescue nil

db.create_table :users, if_not_exists: true
db.add_reference :users, :team, if_not_exists: true rescue nil
db.add_column :users, :username, :string, if_not_exists: true
db.add_column :users, :slack_id, :string, if_not_exists: true

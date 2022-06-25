ActiveRecord::Base.establish_connection(
  YAML.safe_load(
    ERB.new(
      File.read('config/postgresql.yml')
    ).result, [], [], true
  )[ENV.fetch('RACK_ENV', nil)]
)

ActiveRecord::Base.connection.create_table :mails, if_not_exists: true do |t|
  t.references :team, if_not_exists: true
  t.string :from_user_id, if_not_exists: true
  t.string :to_user_id, if_not_exists: true
  t.string :text, if_not_exists: true
  t.boolean :sent, default: false, if_not_exists: true
  t.timestamps
end

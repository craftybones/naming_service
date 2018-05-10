module BatchHelper
  def setup_batch batch
    batch.email ||= Email.new({category: 'Batch'})
    batch.slack ||= Slack.new
    batch
  end
end

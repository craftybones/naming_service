module BatchHelper
  def setup_batch batch
    batch.email ||= Email.new({category: 'Batch'})
    batch
  end
end

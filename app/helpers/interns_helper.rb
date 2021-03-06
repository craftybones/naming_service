module InternsHelper

  def setup_intern intern
    intern.github ||= Github.new
    intern.slack ||= Slack.new
    intern.dropbox ||= Dropbox.new
    if intern.emails.empty?
      intern.emails = ['ThoughtWorks', 'Personal'].map {|category|
        Email.new({category: category})
      }
    end
    intern
  end

  def profile_picture_id id
    if id.present?
      id
    else
      "default.png"
    end

  end
end

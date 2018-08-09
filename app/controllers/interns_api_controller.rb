class InternsApiController < ApiController

  def search
    interns = Intern.search(params[:q]).uniq
    render json: interns, include: [:batch, :github, :emails, :dropbox, :slack]
  end

  def filter
    interns = Intern.all
    filtering_params.each do |key, value|
      interns = interns.public_send(key, value) if value.present?
    end
    interns = interns.uniq
    render json: interns, include: [:batch, :github, :emails, :dropbox, :slack]
  end

  private
  def filtering_params
    params.slice(:emp_id, :display_name, :first_name, :last_name, :email, :batch, :dob, :phone_number, :gender,
                 :github_username, :slack_username, :dropbox_username)
  end
end
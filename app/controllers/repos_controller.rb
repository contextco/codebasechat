class ReposController < ApplicationController

  def index
  end

  def action
    @errors = nil

    @repo = Repo.new(url: params[:repo], email: params[:email])
    @repo.save!
    ProcessRepoJob.perform_later(@repo)
  end

  def async_load_repo
    @clone = Clone.new(params[:repo])
    @file = @clone.file_from_repo
    send_data @file, filename: 'repo.md'


  end
end

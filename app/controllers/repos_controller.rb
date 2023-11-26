class ReposController < ApplicationController

  def index
  end

  def action
    @repo = Repo.new(url: params[:repo], email: params[:email])
    render and return unless @repo.valid?

    @repo.save!
    ProcessRepoJob.perform_later(@repo)
  end

  def async_load_repo
    @clone = Clone.new(params[:repo])
    @file = @clone.file_from_repo
    send_data @file, filename: 'repo.md'


  end
end

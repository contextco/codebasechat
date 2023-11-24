class ProcessRepoJob < ApplicationJob
  queue_as :default

  def perform(repo, *args)
    file = Clone.new(repo.url).file_from_repo
    repo.indexed_repo_file.attach(io: file, filename: 'repo.md')
  end
end

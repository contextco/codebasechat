class RepoMailer < ApplicationMailer
  def repo_created(repo)
    @repo = repo
    mail(from: 'CodebaseChat <alex@codebasechat.com>', to: repo.email, subject: 'Your codebase GPT is ready to be created.')
  end
end

class RepoMailer < ApplicationMailer
  def repo_created(repo)
    @repo = repo
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo_email.png'))
    mail(from: 'CodebaseChat <alex@codebasechat.com>', to: repo.email, subject: 'Your codebase GPT is ready to be created.')
  end
end

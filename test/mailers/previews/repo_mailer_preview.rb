# Preview all emails at http://localhost:3000/rails/mailers/repo_mailer
class RepoMailerPreview < ActionMailer::Preview
  def repo_created
    repo = Repo.new(
      email: 'alex@context.ai'
    )
    repo.indexed_repo_file.attach(io: StringIO.new("Hi"), filename: 'repo.md')
    RepoMailer.repo_created(repo)
  end

end

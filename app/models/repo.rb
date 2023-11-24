class Repo < ApplicationRecord
  has_one_attached :indexed_repo_file

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end

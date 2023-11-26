class Repo < ApplicationRecord
  has_one_attached :indexed_repo_file

  HUMANIZED_ATTRIBUTES = {
    :email => "E-mail address",
    :url => "Github Repository URL"
  }

  validates :url, format: {
    with: /\Ahttps:\/\/github\.com\/[a-zA-Z0-9._-]+\/[a-zA-Z0-9._-]+\z/,
    message: 'must be valid and present.'
  }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'address string must be present and valid.' }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end

class Link < ApplicationRecord

  validates :url, presence: true
  validates :slug, presence: true, uniqueness: true

  validates :url, format: URI::regexp(%w[http https])
  validates :url, length: { in: 3..255, message: "too long" }, on: :create
  validates :slug, length: { in: 3..255 , message: "too long"}, on: :create

  def short
    Rails.application.routes.url_helpers.short_url(slug: self.slug, host: 'www.kbpr.sch.bme.hu', protocol: 'https')
  end
  
end
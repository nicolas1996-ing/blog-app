class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  scope :sorted, -> { order(published_at: :desc, updated_at: :desc) } # if two blog posts have the same published_at date, the one that was updated last will be shown first
  scope :draft , -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= (?)", Time.current) }
  scope :scheduled, -> { where("published_at > (?)", Time.current) }

  def draft? 
    published_at.nil?
  end

  def published? 
    published_at? && published_at <= Time.zone.now
  end

  def scheduled?
    published_at? && published_at > Time.zone.now
  end
end

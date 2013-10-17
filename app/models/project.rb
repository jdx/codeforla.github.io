class Project < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  def embedly
    @embedly ||= Embedly.new(url) if url
  end
end

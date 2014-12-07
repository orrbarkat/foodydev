class Publication < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 200 }
  validates :version, presence: true

  before_validation :set_version

  def set_version
    self.version = version.to_i + 1
  end
end

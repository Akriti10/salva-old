class Projecttype < ActiveRecord::Base
   has_many :projects
  validates_numericality_of :id, :allow_nil => true, :only_integer => true

  validates_presence_of :name
  validates_uniqueness_of :name
end

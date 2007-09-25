class UserRoleingroup < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :roleingroup_id, :allow_nil => true, :only_integer => true
  validates_presence_of :user_id, :roleingroup_id
  validates_uniqueness_of :user_id, :scope => [:roleingroup_id]
  belongs_to :user
  belongs_to :roleingroup
end

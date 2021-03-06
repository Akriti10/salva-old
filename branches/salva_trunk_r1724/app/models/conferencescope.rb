class Conferencescope < ActiveRecord::Base
validates_numericality_of :id, :allow_nil => true, :only_integer => true
validates_uniqueness_of :id
validates_presence_of :name
validates_uniqueness_of :name
end

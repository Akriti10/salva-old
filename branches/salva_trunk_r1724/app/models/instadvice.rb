class Instadvice < ActiveRecord::Base
validates_presence_of :title, :institution_id, :instadvicetarget_id, :year
validates_numericality_of :institution_id, :instadvicetarget_id
belongs_to :institution
belongs_to :instadvicetarget
end

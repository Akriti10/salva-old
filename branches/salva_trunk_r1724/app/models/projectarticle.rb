class Projectarticle < ActiveRecord::Base
validates_presence_of :project_id, :article_id
validates_numericality_of :project_id, :article_id
belongs_to :project
belongs_to :article
end

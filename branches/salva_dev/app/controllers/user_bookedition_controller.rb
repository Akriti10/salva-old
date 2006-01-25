class UserBookeditionController < SalvaController
  def initialize
    super
    @model = UserBookedition
  end

  def per_pages
    10
  end
  
  def order_by
    'title DESC'
  end

end

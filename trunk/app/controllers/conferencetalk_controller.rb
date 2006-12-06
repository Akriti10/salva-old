class ConferencetalkController < SalvaController
  def initialize
    super
    @model = Conferencetalk
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:conference], :conditions => "conferences.istechnical = 'f' AND conferencetalks.conference_id = conferences.id "}
  end
end

class UserSpecialcourseController < SalvaController
  def initialize
    super
    @model = UserCourse
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:roleincourse], :conditions => "roleincourses.name != 'Asistente' AND roleincourses.id =user_courses.roleincourse_id"}
  end
end
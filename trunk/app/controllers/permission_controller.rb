class PermissionController < SalvaController
  def initialize
    super
    @model = Permission
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'controller_id, action_id, id'
  end
end
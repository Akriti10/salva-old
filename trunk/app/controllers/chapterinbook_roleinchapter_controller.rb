class ChapterinbookRoleinchapterController < MultiSalvaController
  def initialize
    super
    @model = ChapterinbookRoleinchapter
    @views = [ :chapterinbook, :book, :bookedition, :chapterinbook_roleinchapter ]
    @models = [ ChapterinbookRoleinchapter, [Chapterinbook, [Bookedition, Book] ] ]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end

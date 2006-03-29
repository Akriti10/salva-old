module TableHelper
  def table_list(collection, options = {} )
    options = options.stringify_keys
    header = options['header']
    columns = options['columns']
    
    list = []
    collection.each { |item|
      cell = []
      if columns.is_a?Array then
        columns.each { |attr| 
          if item.send(attr) != nil then
            if is_id?(attr) then
              (model, field) = set_belongs_to(attr)
              cell << item.send(model).send(field) if item.send(model) != nil
            else
              cell << item.send(attr) if item.send(attr) != nil
            end
          end
        } 
      else
        item.attributes().each { |key, value| cell << value if key != 'id' and value != nil } 
      end
      cell_content = cell.join(', ').to_s+'.'
      list.push({'id' => item.id, 'cell_content' => cell_content })
    }
    render(:partial => '/salva/list', :locals => { :header => header, :list => list })
  end
  
  def table_show(collection, options = {})
    options = options.stringify_keys
    belongs_to = options['belongs_to']
    
    default_hidden = %w(id dbtime moduser_id user_id created_on updated_on) 
    hidden = options['hidden']    
    hidden = [ hidden ] unless hidden.is_a?Array
    
    hidden.each { |attr| default_hidden << attr } if hidden != nil
    
    body = []
    collection.each { |column| 
      attr = column.name
      
      if !default_hidden.include?(attr) then
        if is_id?(attr) then
          (model, field) = set_belongs_to(attr)
          body << [ attr, @edit.send(model).send(field) ] if @edit.send(model) != nil 
        else
          case attr 
          when 'sex' 
            body << [ attr, sex(@edit.send(column.name))]
          else
            body << [ attr, @edit.send(attr) ] if @edit.send(attr) != nil
          end
        end
      end
    }
    
    render(:partial => '/salva/show', :locals => { :body => body})
  end
  
  def is_id?(name)
    if name =~/_id$/ then
      true
    end
  end
    
  def set_belongs_to(attr)
    belongs_to = [ attr.sub(/_id$/,''), 'name' ]
    case attr
    when /citizen/
      belongs_to[1] = 'citizen'
    end
    belongs_to
  end

  def sex(condition)
    condition ? 'Femenino' : 'Masculino'
  end
end

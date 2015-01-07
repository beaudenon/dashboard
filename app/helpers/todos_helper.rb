module TodosHelper
  def priority_class priority
    css_class = case priority
      when 0..1 then "badge badge-default"
      when 2..3 then "badge badge-info"
      when 4..5 then "badge badge-success"
      when 6..8 then "badge badge-warning"
      when 9..24 then "badge badge-important"
      else "badge badge-inverse"
    end
  end

  def progress_class progress
    css_class = case progress
      when 0..20 then "progress progress-striped progress-danger active"
      when 20..70 then "progress progress-striped progress-warning active"
      when 70..99 then "progress progress-striped progress-success active"
      else "progress progress-info"
    end
  end

  def button_class progress
    css_class = case progress
      when 0..20 then "btn btn-striped btn-danger"
      when 20..70 then "btn btn-striped btn-warning"
      when 70..99 then "btn btn--striped btn-success"
      else "btn btn-info"
    end
  end

  def color_class color
    css_class = case color
      when "yellow" then "btn btn-warning btn-mini"
      when "green" then "btn btn-success btn-mini"
      when "red" then "btn btn-danger btn-mini"
      when "blue" then "btn btn-primary btn-mini"
      when "cyan" then "btn btn-info btn-mini"
      when "black" then "btn btn-inverse btn-mini"
      else "btn btn-mini"
    end
  end

  def unbadgetize title
    title.gsub(/\[[[:alpha:] ]+\]/, '')
#    title.gsub( "[", "<span class='badge badge-success'>" ).gsub("]", "</span> " )
  end
end

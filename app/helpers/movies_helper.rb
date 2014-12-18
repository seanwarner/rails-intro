module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def hilite(header)
    header == params[:sort_by] ? 'hilite' : ''
  end
  def sortable_link(key)
    title = key.to_s.gsub(/_/, ' ').split.map(&:capitalize).join(' ')
    link_to title, movies_path(:sort_by => key), id: key.to_s + '_header'
  end
end

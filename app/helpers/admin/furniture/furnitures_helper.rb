require 'descriptive_statistics'

module Admin::Furniture::FurnituresHelper
  def is_outlier? item, collection: [], categorical: false, diff_level: 5, use_savanna: false
    return false if collection.length <= 2
    return true if not collection.include? item
    # if processing a categorical collection
    if not categorical
      o = false
      # the outlier detection method
      o |= Savanna::Outliers.get_outliers(collection, :all).include? item if use_savanna
      # we indicate item as outlier if it has 50+ offset from the median element 
      o |= (item - collection.median).abs > diff_level
      # return the flag
      return o
    else
      # return if all varibales are unique
      return true if not collection.detect{ |e| collection.count(e) > 1 }
      # if item is not in mode, then it's an outlier
      return collection.mode != item
    end
      
  end
  
  def outlier_label item, collection: [], categorical: false, diff_level: 5
    make_label color: not(is_outlier?(item, collection: collection, categorical: categorical, diff_level: diff_level)) do
      yield
    end
  end
  def make_label color:, title: ''
    # check if color is boolean?
    if !!color == color
      if color
        color = "success"
      else
        color = "danger"
      end
    end
    concat raw "<span class='label label-#{color}'" + (title.length > 0 ? "title='#{title}' data-toggle='tooltip'" : "") + " style='font-size: inherit'>"
    yield
    concat raw "</span>"
  end
end

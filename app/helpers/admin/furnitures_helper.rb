require 'descriptive_statistics'

module Admin::FurnituresHelper
  def is_outlier? item, collection: [], categorical: false
    return false if collection.length <= 2
    return true if not collection.include? item
    # if processing a categorical collection
    if not categorical
      o = false
      # the outlier detection method
      o |= Savanna::Outliers.get_outliers(collection, :all).include? item
      # duplicate collection
      sub_collection = collection.dup
      # delete the item from duplicated collection
      (index = sub_collection.find_index(item)) && sub_collection.delete_at(index) 
      # if we remove an outlier from the set, the new set's variance is expected to decline
      o |= sub_collection.variance < collection.variance if not sub_collection.empty?
      # return the flag
      return o
    else
      # return if all varibales are unique
      return true if not collection.detect{ |e| collection.count(e) > 1 }
      # if item is not in mode, then it's an outlier
      return collection.mode != item
    end
      
  end
  
  def outlier_label item, collection: [], categorical: false
    make_label color: not(is_outlier?(item, collection: collection, categorical: categorical)) do
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

require 'descriptive_statistics'

module Admin::FurnituresHelper
  def is_outlier? item, collection: []
    return false if collection.length <= 2
    return true if not collection.include? item
    o = false
    # the outlier detection method
    o |= Savanna::Outliers.get_outliers(collection, :all).include? item
    # if we remove an outlier from the set, the new set's variance is expected to decline
    o |= (collection - [item]).variance < collection.variance
    o
  end
end

class Admin::PushNotification < ApplicationRecord
  validates_presence_of :message, :category
end

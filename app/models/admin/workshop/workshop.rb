class Admin::Workshop::Workshop < ApplicationRecord
  belongs_to :state
  belongs_to :user
end

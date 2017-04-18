class Admin::AdminbaseController < ApplicationController
  layout proc { prefer_layout 'no_navbar' }
end

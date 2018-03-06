# This is an examble, modify it as well
Acu::Rules.define do
  # anyone make a request could be count as everyone!
  whois :everyone { true }
  # folks who signed in
  whois :signed_in, args: [:user] { |user| user }
  # folks who didn't signed in
  whois :guest, args: [:user] { |user| not user }
  # other user entities
  [
    :ADMIN, :GRAPHIC, :FANI,
    :MARKETER, :MARKLINE, :NAGASH,
    :NAJAR, :PR, :CLIENT, :KALAF
  ].each do |symbol|
    whois symbol.downcase.to_sym, args: [:user] { |user| user and user.type && user.type.symbol == symbol.to_s }
  end

  # employees are those who are members and signed-in and not (:ADMIN or :CLIENT)
  whois :employee,  args: [:user] { |user| not(acu_is?([:guest, :admin, :client])) }

  # non-admin entities
  whois :non_admin, args: [:user] { |user| not(acu_is?(:admin)) }

  # by default admin can go everywhere
  allow :admin

  # default namespace
  namespace except: [:profiles] do
    allow :everyone
  end

  # allow everyone to order
  namespace :order do
    allow :everyone
  end

  namespace do
    controller :profiles do
      deny :everyone, on: [:destroy]
      allow :signed_in
    end
    controller :api do
      deny :non_admin, on: [:payment_test]
    end
  end

  namespace :admin do
    # define the none-destroyable controllers
    controller [:users, :user_types, :furniture_specs, :furniture_sections] do
      deny :everyone, on: [:destroy]
    end

    # we only can view user types, nothing else!
    controller :user_types, except: [:index] do
      deny :everyone
    end

    # allowing employees to see the list images for a furniture
    controller :furnitures do
      allow :employee, on: [:list_images]
    end

    # no-one can update/destroy anything in `pricing` namespace
    namespace :pricing, except: [:transits, :fabrics, :woods, :paint_colors, :foams] do
      deny :everyone, on: [:destroy]
    end

    namespace :selling do
      namespace :config do
        # don't allow anyone to delete a record from profit
        controller :profits do
          deny :everyone, on: [:destroy]
        end
      end
    end
  end

  namespace :employee do
    allow :employee
    # people can only create new stuff in database
    # not updating them
    deny  :everyone, on: [:destroy, :new, :show, :update]

    # only admin can `update` stuff
    action :update_field do
      allow :admin
      deny  :employee
    end

    controller :home do
      deny :employee, on: [:as]
    end
  end

  # devise login namespace
  namespace :devise, :users do
    allow :everyone
    controller :sessions do
      deny :guest, on: [:verify, :confirm]
    end
  end
end
# This is an examble, modify it as well
Acu::Rules.define do
  # anyone make a request could be count as everyone!
  whois :everyone { true }

  [
    :ADMIN, :GRAPHIC, :KHAYAT,
    :MARKETER, :MARKLINE, :NAGASH,
    :NAJAR, :PR, :CLIENT, :ROKOB
  ].each do |symbol|
    whois symbol.downcase.to_sym, args: [:user] { |user| user and user.user_type && user.user_type.symbol == symbol.to_s }
  end

  # by default admin can go everywhere
  allow :admin

  # default namespace
  namespace do
    allow :everyone
    controller :profile do
      deny :everyone, on: [:delete]
    end
  end

  # devise login namespace
  namespace :devise, :users do
    allow :everyone
  end
end
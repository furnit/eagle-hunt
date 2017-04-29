class User < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, 
         :recoverable

  has_one :profile, autosave: true
  belongs_to :user_type, class_name: 'Admin::UserType', foreign_key: :admin_user_type_id

  validates :phone_number, length: { is: 11 }, uniqueness: true
  validates_format_of :phone_number, :with => /09\d{2}[- ]?\d{3}[- ]?\d{4}/i

  before_validation :normalize_phone_number
  after_initialize :normalize_phone_number

  before_save :check_if_password_changed?

  def helper
    @helper ||= Class.new do
      # include `number_to_phone`
      include ActionView::Helpers::NumberHelper
    end.new
  end
  
  # secure sensitive details on json request
  def as_json(options)
    super(:except => [:reset_password_token, :encrypted_password, :phone_number, :email])
  end
  
  def reset_password
    @reset_password = true
    self.change_password = true;
    self.password = self.phone_number
    self.password_confirmation = self.password
    return self
  end

  def reset_two_step_auth
    [:two_step_auth_token, :two_step_auth_token_sent_at, :two_step_auth_token_confirmed_at].each { |c| self[c] = nil }
    return self
  end

  def normalize_phone_number
    self.phone_number = self.phone_number.to_ar2en_i;
    self.phone_number = helper.number_to_phone(self.phone_number.strip, delimiter: "", pattern: /(\d{4})[- ]?(\d{3})[- ]?(\d{4})$/)
  end

  def self.authenticate(phone_number, password, with_deleted = "with_deleted")
    user = eval("User.#{with_deleted}.find_for_authentication(:phone_number => '#{phone_number}')")
    user and user.valid_password?(password) ? user : nil
  end

  def check_if_password_changed?
    self.change_password = false if self.encrypted_password_changed? and not @reset_password
  end

	def email_required?
    false
  end

  def email_changed?
    false
  end

  def full_name
    return 'بدون نام' if self.profile == nil
    '%s %s' %[self.profile.first_name, self.profile.last_name]
  end

  ######## Filtering ########

    filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
        :sorted_by,
        :search_query,
        :get_by_user_types,
        :get_by_states,
        :get_by_status
      ]
    )


    scope :search_query, lambda { |query|
      return nil  if query.blank?
      # condition query, parse into individual keywords
      terms = query.downcase.split(/\s+/)
      # replace "*" with "%" for wildcard searches,
      # append '%', remove duplicate '%'s
      terms = terms.map { |e|
        (e.gsub('*', '%') + '%').gsub(/%+/, '%')
      }
      # configure number of OR conditions for provision
      # of interpolation arguments. Adjust this if you
      # change the number of OR conditions.
      num_or_conditions = 5
      joins(:profile).
      joins(:user_type).
      where(
        terms.map {
          or_clauses = [
            "LOWER(profiles.first_name) LIKE ?",
            "LOWER(profiles.last_name) LIKE ?",
            "LOWER(profiles.address) LIKE ?",
            "LOWER(users.phone_number) LIKE ?",
            "LOWER(users.id) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
      )
    }

    scope :get_by_user_types, lambda { |user_type_id|
      where("admin_user_type_id = ?", user_type_id)
    }

    scope :get_by_states, lambda { |state|
      joins(:profile).
      where('profiles.state_id = ?', state)
    }
    scope :get_by_status, lambda { |status|
      case status.to_s.downcase
      when "active"
        where('users.deleted_at IS NULL and users.blocked_at IS NULL and current_sign_in_at IS NOT NULL')
      when "deleted_at"
        where('users.deleted_at IS NOT NULL')
      when "blocked_at"
        where('users.blocked_at IS NOT NULL')
      else
        raise(ArgumentError, "Invalid status option: #{ status.inspect }")
      end
    }

    scope :sorted_by, lambda { |sort_option|
      # extract the sort direction from the param value.
      direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
      case sort_option.to_s
      when /^created_at_/
        order("users.created_at #{ direction }")
      when /^current_sign_in_at_/
        order("users.current_sign_in_at #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
      end
    }

    def self.options_for_sorted_by
      [
        ['زمان عضویت (جدیدترین در ابتدا)', 'created_at_desc'],
        ['زمان عضویت (قدیمی‌ترین در ابتدا)', 'created_at_asc'],
        ['زمان آخرین ورود (جدیدترین در ابتدا)', 'current_sign_in_at_asc'],
        ['زمان آخرین ورود (قدیمی‌ترین در ابتدا)', 'current_sign_in_at_desc'],
      ]
    end
    def self.options_for_get_by_status
      [
        ['حساب‌های فعال', 'active'],
        ['حسا‌ب‌های معلق', 'deleted_at'],
        ['حساب‌های مسدود', 'blocked_at'],
      ]
    end


end

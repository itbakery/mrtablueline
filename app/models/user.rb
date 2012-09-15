class User
  include Mongoid::Document
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  field :name , :type => String , :default => ""
  validates_presence_of :name
  validates_uniqueness_of :name, :email , :case_sensitive => false
  validates_presence_of :email
  validates_presence_of :encrypted_password
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at, :company_id, :profile_attributes, :role_ids
   belongs_to  :company
   has_one  :profile
   accepts_nested_attributes_for  :profile
   has_many :activities
   has_many :announces
   has_many :pages
   has_many :reports
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
   field :confirmation_token,   :type => String
   field :confirmed_at,         :type => Time
   field :confirmation_sent_at, :type => Time
   field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  def self.current_user
    Thread.current[:current_user].first unless Thread.current[:current_user].nil?
  end

  def self.current_user=(usr)
    Thread.current[:current_user] = usr
  end

  def self.admin_emails
    Role.where(name: 'admin').first.users.map(&:email)
  end
   def self.role_emails(role)
    Role.where(name: role).first.users.map(&:email)
  end

  def self.role_users(role)
    Role.where(name: role).first.users
  end
 #role management
  #admin
  #supervisor
  #mrtaadmin
  #author
  def assign_supervisor_role

  end
  def remove_supervisor_role
  end
  def assign_mrtaadmin_role
  end
  def remove_mrtaadmin_role
  end
  def assign_author_role
  end
  def remove_author_role
  end
end

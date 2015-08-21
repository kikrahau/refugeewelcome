class User < ActiveRecord::Base
	has_and_belongs_to_many :categories, -> { uniq }	
  belongs_to :city_district
  enum role: [:user, :vip, :admin]
  
  after_initialize :set_default_role, :if => :new_record?

  validates :zip, numericality: true, length: {in: (4..5),within: (1100..99999)}

  validate :email_validator

  before_save :set_city

  attr_accessor :zip 

  def set_city
    city= CityDistrict.find_by(zip: zip)
    self.city_district_id = city.id || CityDistrict.first.id
  end

  def email_validator
    errors.add(:email,'Email muss min. 8 Zeichen haben') unless email.to_s.length > 7
    errors.add(:email,'@ Zeichen fehlt') unless email.include?('@')
    errors.add(:email,'Domain ist nicht korrekt') unless email =~ /\.\w{2,4}$/
    errors.add(:email,'falsches Format') unless email =~ /^[\w_\-\.]+\@[\w_\-\.]+$/i
    false
  end

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

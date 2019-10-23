class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  has_person_name

  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :bids, dependent: :destroy
end

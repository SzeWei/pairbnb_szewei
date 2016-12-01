class Listing < ActiveRecord::Base
	
	belongs_to :user
	has_many :reservations
	mount_uploaders :photos, PhotosUploader

	include PgSearch
	pg_search_scope :search_by_address, :against => :address
end

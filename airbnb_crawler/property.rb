class Property 
  attr_accessor :address, :has_video, :id, :lat, :lng, :name, :other_review_count, :picture_ids, :price, :review_count, :room_type, :thumbnail_url 

  def initialize(hash)
    @address = hash["address"]
    @has_video = hash["has_video"]
    @id = hash["id"]
    @lat = hash["lat"]
    @lng = hash["lng"]
    @name = hash["name"]
    @other_review_count = hash["other_review_count"]
    @price = hash["price"]
    @review_count = hash["review_count"]
    @room_type = hash["room_type"]
    @thumbnail_url = hash["thumbnail_url"]
  end
end

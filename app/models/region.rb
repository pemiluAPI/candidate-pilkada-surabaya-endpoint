class Region < ActiveRecord::Base
	has_many :candidates
	belongs_to :province

  validates :province_id, :name,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }
  scope :by_province_id, lambda{ |province_id| where("province_id = ?", province_id) unless province_id.nil? }

  def self.apiall(data = {})
    regions          = self.by_id(data[:id]).by_province_id(data[:province_id])
    paginate_regions = regions.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      regions: paginate_regions.map{|value| value.construct},
      count: paginate_regions.count,
      total: regions.count
		}
  end

  def construct
    return {
      id: id,
      province: (province.construct if province),
      name: name,
      kind: kind
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end

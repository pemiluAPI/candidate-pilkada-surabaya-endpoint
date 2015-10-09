class Province < ActiveRecord::Base
	has_many :regions

  validates :name,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }

  def self.apiall(data = {})
    provinces          = self.by_id(data[:id])
    paginate_provinces = provinces.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      provinces: paginate_provinces.map{|value| value.construct},
      count: paginate_provinces.count,
      total: provinces.count
		}
  end

  def construct
    return {
      id: id,
      name: name
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end

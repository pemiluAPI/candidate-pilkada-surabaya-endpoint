class VisionMision < ActiveRecord::Base
	belongs_to	:candidate

  validates :candidate_id,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }
  scope :by_candidate_id, lambda{ |candidate_id| where("candidate_id = ?", candidate_id) unless candidate_id.nil? }

  def self.apiall(data = {})
    vision_missions          = self.by_id(data[:id]).by_candidate_id(data[:candidate_id])
    paginate_vision_missions = vision_missions.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      vision_missions: paginate_vision_missions.map{|value| value.construct},
      count: paginate_vision_missions.count,
      total: vision_missions.count
		}
  end

  def construct
    return {
      id: id,
      candidate_id: candidate_id,
      vision: vision,
      mision: mision
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end

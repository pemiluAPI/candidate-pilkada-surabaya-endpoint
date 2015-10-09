class Candidate < ActiveRecord::Base
	has_many :participants
	has_one	:vision_mision
	belongs_to :region

  validates :region_id, :endorsement_type, :vote_type,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }
  scope :by_region_id, lambda{ |region_id| where("region_id = ?", region_id) unless region_id.nil? }
  scope :by_province_id, lambda{ |province_id| joins(:region).where("regions.province_id = ?", province_id) unless province_id.nil? }

  def self.apiall(data = {})
    candidates          = self.by_id(data[:id]).by_region_id(data[:region_id]).by_province_id(data[:province_id])
    paginate_candidates = candidates.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      candidates: paginate_candidates.map{|value| value.construct},
      count: paginate_candidates.count,
      total: candidates.count
		}
  end

  def construct
    return {
    	id: id,
    	participants: participants.map {|value| value.construct},
    	region: (region.construct if region),
    	endorsement_type: endorsement_type,
    	endorsement: endorsement,
    	vote_type: vote_type,
    	acceptance_status: acceptance_status,
    	document_completeness: document_completeness,
    	research_result: research_result,
    	acceptance_document_repair: acceptance_document_repair,
    	amount_support: amount_support,
    	amount_support_repair: amount_support_repair,
    	amount_support_determination: amount_support_determination,
    	eligibility_support: eligibility_support,
    	eligibility_support_repair: eligibility_support_repair,
    	pertahana: pertahana,
    	dynasty: dynasty,
    	amount_women: amount_women,
    	incumbent: incumbent
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end

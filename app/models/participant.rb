class Participant < ActiveRecord::Base
	belongs_to :candidate

	def construct
		return {
			kind: kind,
			name: name,
			gender: gender,
			pob: pob,
			dob: dob,
			address: address,
			work: work,
			status: status
		}
	end

end

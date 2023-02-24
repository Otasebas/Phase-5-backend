class Friendrequest < ApplicationRecord

    validates_presence_of :requestor_id, :receiver_id

    def check_ids
        if self.requestor_id == self.receiver_id
            errors.add(:requestor, "can't be the same as email" ) 
        end
    end
end

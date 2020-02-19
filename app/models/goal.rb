class Goal < ActiveRecord::Base 
    belongs_to :user
    validates :content, presence: true

    def self.find_goals_by_user(current_user)
        goals = self.all.select { |goal| goal.user_id == current_user.id } 
    end


end


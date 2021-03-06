class Goal < ActiveRecord::Base 
    belongs_to :user
    validates :content, presence: true

    def self.find_goals_by_user(current_user)
        goals = self.all.select { |goal| goal.user_id == current_user.id } 
    end

    def self.completed_goals
        self.all.select { |goal| goal.completed != nil}
    end

    def self.not_completed_goals
        self.all.select { |goal| goal.completed == nil}
    end

    def self.percent_complete
        total_completed = self.completed_goals.length
        not_completed_goals_length = self.not_completed_goals.length
        total_goals = total_completed + not_completed_goals_length
        # binding.pry
        (total_completed/total_goals.to_f * 100).round(2)
    end

    def slug
        self.content.downcase.gsub(/\s+/, '-')
    end

    def self.find_by_slug(slug)
        self.all.find{ |goal_slug| goal_slug.slug == slug }
    end


end


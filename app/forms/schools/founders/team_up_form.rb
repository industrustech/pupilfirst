module Schools
  module Founders
    class TeamUpForm < Reform::Form
      property :founder_ids, validates: { presence: true }, virtual: true

      validate :founders_must_be_in_same_level
      validate :at_least_one_founder

      def founders_must_be_in_same_level
        return if founders.blank?
        return if founders.joins(startup: :level).distinct('levels.id').pluck('levels.id').one?

        errors[:base] << 'Students in different levels cannot be teamed up'
      end

      def at_least_one_founder
        return if founders.exists?

        errors[:base] << 'At least one student must be selected'
      end

      def save
        ::Startups::TeamUpService.new(founders).team_up(team_name)
      end

      private

      def founders
        Founder.where(id: founder_ids)
      end

      def team_name
        ::Startups::ProductNameGeneratorService.new.fun_name
      end
    end
  end
end

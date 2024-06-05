require_relative 'summary_strategy'

# Grouping strategy to gropu based on category
class GroupByCategoryStrategy
    include SummaryStrategy
    def summarize(dinos)
      dinos.group_by { |d| d['category'] }.transform_values(&:count)
    end
  end
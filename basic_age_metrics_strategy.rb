require_relative 'age_metrics_strategy'

# Age metrics strategy to calculate age metrics based on comment and age
class BasicAgeMetricsStrategy
    include AgeMetricsStrategy
    def calculate_age_metrics(dino)
      dino['age_metrics'] = dino['comment'] == 'Alive' && dino['age'] > 1 ? (dino['age'] / 2).to_i : 0
    end
  end
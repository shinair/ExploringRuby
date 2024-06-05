require './health_strategy'

# Implementing the calculate_health() method for omnivore strategy
  # Added this to show the effectiveness of using SOLID principles and design patterns
  class OmnivoreHealthStrategy
    include HealthStrategy
    def calculate_health(dino)
      diet = dino['diet'].downcase
      # Can eat both, plants and meat
      dino['health'] = (diet.include?('meat') || diet.include?('plants')) ? 100 - dino['age'] : 0 
    end
  end
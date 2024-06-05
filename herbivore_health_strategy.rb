require './health_strategy'

# Implementing the calculate_health() method for herbivore strategy
class HerbivoreHealthStrategy
    include HealthStrategy
    def calculate_health(dino)
        # Health will be 0 if diet is not plants
      dino['health'] = dino['diet'] == 'plants' ? 100 - dino['age'] : 0  
    end
  end
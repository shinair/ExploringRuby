require './health_strategy'

# Implementing the calculate_health() method for carnivore strategy
class CarnivoreHealthStrategy
    include HealthStrategy
    def calculate_health(dino)
        # Health will be 0 if diet is not meat
      dino['health'] = dino['diet'] == 'meat' ? 100 - dino['age'] : 0  
    end
  end
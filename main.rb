require './dino_manager'

# Instantiate and process dinosaurs using DinoManager
def run_dinosaur_data
  dinosaurs = [
    { "name" => "DinoA", "category" => "herbivore", "period" => "Cretaceous", "diet" => "plants", "age" => 100 },
    { "name" => "DinoB", "category" => "carnivore", "period" => "Jurassic", "diet" => "plants", "age" => 80 },
    { "name" => "DinoA", "category" => "herbivore", "period" => "Cretaceous", "diet" => "meat", "age" => 100 },
    { "name" => "DinoA", "category" => "omnivore", "period" => "Cretaceous", "diet" => "plants and meat", "age" => 20 },
    { "name" => "DinoC", "category" => "carnivore", "period" => "Cretaceous", "diet" => "meat and plants", "age" => -1 }
  ]

  manager = DinoManager.new(dinosaurs)
  results = manager.process_dinos
  results[:dinos].each do |dino|
    puts "Name: #{dino['name']}, Category: #{dino['category']}, Period: #{dino['period']}, Diet: #{dino['diet']}, Age: #{dino['age']}, Health: #{dino['health']}, Comment: #{dino['comment']}, Age Metrics: #{dino['age_metrics']}"
  end
  puts "Summary: #{results[:summary]}"
end

run_dinosaur_data
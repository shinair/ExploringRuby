# Test Cases:
# - The test suite verifies that each dinosaur's health is calculated correctly based on its diet
#   and category, ensuring strict adherence to dietary restrictions.
# - It checks that comments reflect the current health status of each dinosaur, showing correct condition ('Alive' or 'Dead').
# - The program's ability to summarize the dinosaur data by categories is thoroughly tested.
# - Program's ability to handle empty values and throw exceptions is also thoroughly tested. 


# Test cases begin here

require './dino_manager'
require 'rspec'

describe "Dino Management" do
  let(:dino_data) {
    [
      { "name" => "DinoA", "category" => "herbivore", "period" => "Cretaceous", "diet" => "plants", "age" => 20 },
      { "name" => "DinoE", "category" => "herbivore", "period" => "Jurassic", "diet" => "meat", "age" => 50 },
      { "name" => "DinoB", "category" => "carnivore", "period" => "Jurassic", "diet" => "meat", "age" => 80 },
      { "name" => "DinoC", "category" => "omnivore", "period" => "Cretaceous", "diet" => "plants and meat", "age" => 20 }
    ]
  }

  describe "Health Strategies" do
    it "calculates health for herbivores" do
      # Test herbivore health calculation with correct diet and age
      strategy = HerbivoreHealthStrategy.new
      dino = { "diet" => "plants", "age" => 20 }
      strategy.calculate_health(dino)
      expect(dino['health']).to eq(80)
    end

    it "sets health to 0 for herbivores not eating plants" do
      # Test herbivore health calculation with incorrect diet
      strategy = HerbivoreHealthStrategy.new
      dino = { "diet" => "meat", "age" => 20 }
      strategy.calculate_health(dino)
      expect(dino['health']).to eq(0)
    end

    it "calculates health for carnivores" do
      # Test carnivore health calculation with correct diet and age
      strategy = CarnivoreHealthStrategy.new
      dino = { "diet" => "meat", "age" => 30 }
      strategy.calculate_health(dino)
      expect(dino['health']).to eq(70)
    end

    it "sets health to 0 for carnivores not eating meat" do
      # Test carnivore health calculation with incorrect diet
      strategy = CarnivoreHealthStrategy.new
      dino = { "diet" => "plants", "age" => 30 }
      strategy.calculate_health(dino)
      expect(dino['health']).to eq(0)
    end

    it "calculates health for omnivores" do
      # Test omnivore health calculation with correct diet and age
      strategy = OmnivoreHealthStrategy.new
      dino = { "diet" => "plants and meat", "age" => 25 }
      strategy.calculate_health(dino)
      expect(dino['health']).to eq(75)
    end

    it "sets health to 0 for omnivores not eating plants or meat" do
      # Test omnivore health calculation with incorrect diet
      strategy = OmnivoreHealthStrategy.new
      dino = { "diet" => "fruits", "age" => 25 }
      strategy.calculate_health(dino)
      expect(dino['health']).to eq(0)
    end
  end

  describe "Comment Strategy" do
    it "assigns 'Alive' if health is greater than 0" do
      # Test comment assignment for health > 0
      strategy = SimpleCommentStrategy.new
      dino = { "health" => 50 }
      strategy.update_comment(dino)
      expect(dino['comment']).to eq('Alive')
    end

    it "assigns 'Dead' if health is 0 or less" do
      # Test comment assignment for health <= 0
      strategy = SimpleCommentStrategy.new
      dino = { "health" => 0 }
      strategy.update_comment(dino)
      expect(dino['comment']).to eq('Dead')
    end
  end

  describe "Age Metrics Strategy" do
    it "calculates age metrics for alive dinosaurs older than 1" do
      # Test age metrics calculation for alive dinosaur with age > 1
      strategy = BasicAgeMetricsStrategy.new
      dino = { "comment" => "Alive", "age" => 10 }
      strategy.calculate_age_metrics(dino)
      expect(dino['age_metrics']).to eq(5)
    end

    it "sets age metrics to 0 for dead dinosaurs" do
      # Test age metrics calculation for dead dinosaur
      strategy = BasicAgeMetricsStrategy.new
      dino = { "comment" => "Dead", "age" => 10 }
      strategy.calculate_age_metrics(dino)
      expect(dino['age_metrics']).to eq(0)
    end

    it "sets age metrics to 0 for alive dinosaurs aged 1 or less" do
      # Test age metrics calculation for alive dinosaur with age <= 1
      strategy = BasicAgeMetricsStrategy.new
      dino = { "comment" => "Alive", "age" => 1 }
      strategy.calculate_age_metrics(dino)
      expect(dino['age_metrics']).to eq(0)
    end
  end

  describe "Summary Strategy" do
    it "groups dinosaurs by category and counts them" do
      # Test grouping and counting dinosaurs by category
      strategy = GroupByCategoryStrategy.new
      dinos = [
        { "category" => "herbivore" },
        { "category" => "herbivore" },
        { "category" => "carnivore" },
        { "category" => "omnivore" }
      ]
      summary = strategy.summarize(dinos)
      expect(summary).to eq({ "herbivore" => 2, "carnivore" => 1, "omnivore" => 1 })
    end
  end

  describe "DinoManager" do
    it "processes dinosaur data correctly" do
      # Test the entire dinosaur data processing workflow
      manager = DinoManager.new(dino_data)
      results = manager.process_dinos
      dinos = results[:dinos]
      summary = results[:summary]

      expect(dinos[0]['health']).to eq(80)
      expect(dinos[0]['comment']).to eq('Alive')
      expect(dinos[0]['age_metrics']).to eq(10)

      expect(dinos[1]['health']).to eq(0)
      expect(dinos[1]['comment']).to eq('Dead')
      expect(dinos[1]['age_metrics']).to eq(0)

      expect(dinos[2]['health']).to eq(20)
      expect(dinos[2]['comment']).to eq('Alive')
      expect(dinos[2]['age_metrics']).to eq(40)

      expect(dinos[3]['health']).to eq(80)
      expect(dinos[3]['comment']).to eq('Alive')
      expect(dinos[3]['age_metrics']).to eq(10)

      expect(summary).to eq({ "herbivore" => 2, "carnivore" => 1, "omnivore" => 1 })
    end

    it "raises an error for missing name" do
      # Test error raising for missing name
      dino_data_invalid = [
        { "name" => "", "category" => "herbivore", "period" => "Cretaceous", "diet" => "plants", "age" => 20 }
      ]
      expect { DinoManager.new(dino_data_invalid) }.to raise_error(ArgumentError, "Name is missing")
    end

    it "raises an error for missing category" do
      # Test error raising for missing category
      dino_data_invalid = [
        { "name" => "DinoA", "category" => "", "period" => "Cretaceous", "diet" => "plants", "age" => 20 }
      ]
      expect { DinoManager.new(dino_data_invalid) }.to raise_error(ArgumentError, "Category is missing")
    end

    it "raises an error for missing period" do
      # Test error raising for missing period
      dino_data_invalid = [
        { "name" => "DinoA", "category" => "herbivore", "period" => "", "diet" => "plants", "age" => 20 }
      ]
      expect { DinoManager.new(dino_data_invalid) }.to raise_error(ArgumentError, "Period is missing")
    end

    it "raises an error for missing diet" do
      # Test error raising for missing diet
      dino_data_invalid = [
        { "name" => "DinoA", "category" => "herbivore", "period" => "Cretaceous", "diet" => "", "age" => 20 }
      ]
      expect { DinoManager.new(dino_data_invalid) }.to raise_error(ArgumentError, "Diet is not specified correctly")
    end

    it "raises an error for invalid category" do
      # Test error raising for invalid category
      dino_data_invalid = [
        { "name" => "DinoA", "category" => "invalid_category", "period" => "Cretaceous", "diet" => "plants", "age" => 20 }
      ]
      expect { DinoManager.new(dino_data_invalid) }.to raise_error(ArgumentError, "Invalid category: invalid_category")
    end
  end
end
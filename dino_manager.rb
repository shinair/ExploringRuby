

require_relative 'herbivore_health_strategy'
require_relative 'carnivore_health_strategy'
require_relative 'omnivore_health_strategy'
require_relative 'simple_comment_strategy'
require_relative 'basic_age_metrics_strategy'
require_relative 'group_by_category_strategy'

# Initialize each strategy, iterate and validate input data
class DinoManager
    def initialize(dinos)
      @dinos = dinos.map do |dino|
        validate_dino(dino)
        dino['health_strategy'] = select_strategy(dino['category'])
        dino
      end
      @comment_strategy = SimpleCommentStrategy.new
      @age_metrics_strategy = BasicAgeMetricsStrategy.new
      @summary_strategy = GroupByCategoryStrategy.new
    end
  
    # Process each dino in the input
    def process_dinos
      @dinos.each do |dino|
        dino['health'] = dino['health_strategy'].calculate_health(dino)
        @comment_strategy.update_comment(dino)
        @age_metrics_strategy.calculate_age_metrics(dino)
      end
      summary = @summary_strategy.summarize(@dinos)
      { dinos: @dinos, summary: summary }
    end
  
    private
  
    # Validate Name, Category, Period, Age and Diet input values
    def validate_dino(dino)
      raise ArgumentError, "Name is missing" if dino['name'].to_s.strip.empty?
      raise ArgumentError, "Category is missing" if dino['category'].to_s.strip.empty?
      raise ArgumentError, "Period is missing" if dino['period'].to_s.strip.empty?
      dino['age'] = [dino['age'].to_i, 1].max
      dino['diet'] = dino['diet'].downcase.strip # Normalize the diet string
      raise ArgumentError, "Diet is not specified correctly" if dino['diet'].empty?
    end
  
    # Choose the appropriate strategy based on the category
    def select_strategy(category)
      case category
      when 'herbivore'
        HerbivoreHealthStrategy.new
      when 'carnivore'
        CarnivoreHealthStrategy.new
      when 'omnivore'
        OmnivoreHealthStrategy.new
      else
        raise ArgumentError, "Invalid category: #{category}"
      end
    end
  end
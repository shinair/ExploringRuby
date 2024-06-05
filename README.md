# Exploring Ruby

This refactored code uses the strategy pattern to encapsulate age calculation, age metrics, comments, and summary operations based on the dinosaur's category.
I used this pattern to decouple these operations from the main application logic, for clearer, more maintainable code.

In addition to implementing the strategy pattern, I also introduced the 'Omnivore' category. This serves as an example of how
the application can be extended using SOLID principles and design patterns to accommodate new requirements without disrupting existing functionality.

Error handling has been introduced to manage ambiguous, missing, or incorrect inputs effectively, ensuring the application's robustness in various scenarios.

# Test Cases:
1. The test suite verifies that each dinosaur's health is calculated correctly based on its diet and category, ensuring strict adherence to dietary restrictions.
2. It checks that comments reflect the current health status of each dinosaur, showing correct condition ('Alive' or 'Dead').
3. The program's ability to summarize the dinosaur data by categories is thoroughly tested.
4. Program's ability to handle empty values and throw exceptions is also thoroughly tested. 

# How to run this code?
1. Install rspec if not installed
```gem install rspec```

3. Run the main file
```ruby main.rb```

4. Run the tests
```rspec .\dino_manager_spec.rb```

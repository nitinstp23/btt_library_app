Kaminari.configure do |config|
  config.default_per_page = 10
  # config.max_per_page = nil
  config.window = 5
  config.outer_window = 5
  # config.left = 2
  # config.right = 2
  # config.page_method_name = :page
  config.param_name = :page
end

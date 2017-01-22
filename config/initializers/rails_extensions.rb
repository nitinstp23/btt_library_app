# Load all Rails extensions
Pathname("#{Rails.root}/lib/btt_library_app/rails_extensions").children.each do |file_path|
  require file_path
end

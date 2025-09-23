ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# config/boot.rb
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)
require "bundler/setup"

require "logger"        # ← add this line (must be BEFORE activesupport/rails load)
# Optional but common; fine to keep:

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

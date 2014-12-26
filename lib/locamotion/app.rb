require 'thor'

module Locamotion

  class App < Thor
    desc 'slurp', "Slurp the app's localized strings into the English localization"

    def slurp
      if File.exists? 'app'
        slurp_main
      else
        abort "Error: 'app' folder not found. Are you running Locamotion in a RubyMotion project?"
      end
    end

    desc 'generate', "Generate the other language's strings based on that of the english localization"

    def generate
      if File.exists? 'resources'
        generate_main
      else
        abort "Error: 'resources' folder not found. Are you running Locamotion in a RubyMotion project?"
      end
    end

    private 

    def slurp_main
      matches = parse_rubymotion_app
      create_folder('resources/en.lproj')
      localizable = 'resources/en.lproj/Localizable.strings'
      system("touch #{localizable}")
      strings_added_count = 0
      matches.each do |string|
        strings_added_count += 1 if add_missing_string(localizable, string)
      end
      announce_slurp_results(strings_added_count)
    end

    def generate_main
      Dir.glob('resources/en.lproj/*.strings') do |strings_file|
        Dir.glob('resources/*.lproj') do |folder|
          next if folder == 'resources/en.lproj'
          strings_added_count = 0
          localized_strings_file = File.join(folder, File.basename(strings_file))
          system("touch #{localized_strings_file}")
          File.open(strings_file).each do |line|
            localizable_string_matcher = /(".*"\s*=\s*".*";)/
            match = line[localizable_string_matcher, 1]
            next unless match
            string = match[/(".*")\s*=/, 1]
            strings_added_count += 1 if add_missing_localized_string(localized_strings_file, string)
          end
          announce_generate_results(strings_added_count, localized_strings_file)
        end
      end
    end

    def create_folder(folder)
      FileUtils.mkdir_p(folder) unless File.exists?(folder)
    end

    def parse_rubymotion_app
      matches = []
      Dir.glob('app/**/*.rb') do |ruby_file|
        File.open(ruby_file).each do |line|
          matches += line.scan(/"([^"]+)"\._/)
          matches += line.scan(/'([^']+)'\._/)
        end
      end
      matches.flatten
    end

    def add_missing_localized_string(file, string)
      added = false
      unless File.open(file).read =~ /#{Regexp.quote(string)}\s*=\s*".*";/
        File.open(file, 'a+') { |f| f.write("#{string} = #{string};\n") }
        added = true
      end
      added
    end

    def add_missing_string(file, string)
      added = false
      unless File.open(file).read =~ /"#{Regexp.quote(string)}"\s*=\s*"#{Regexp.quote(string)}";/
        File.open(file, 'a+') { |f| f.write("\"#{string}\" = \"#{string}\";\n") }
        added = true
      end
      added
    end

    def announce_slurp_results(strings_added_count)
      if strings_added_count > 0
        puts "#{strings_added_count} new string#{strings_added_count == 1 ? '' : 's'} entered into ./resources/en.lproj/Localizable.strings"
      else
        puts 'No new strings added.'
      end
    end

    def announce_generate_results(strings_added_count, localized_strings_file)
      if strings_added_count > 0
        puts "#{strings_added_count} new string#{strings_added_count == 1 ? '' : 's'} entered into #{localized_strings_file}"
      else
        puts "No new strings added to #{localized_strings_file}."
      end
    end
  end
end

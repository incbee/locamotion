require 'thor'

module Locamotion
  class App < Thor
    desc "slurp", "Slurp the app's localized strings into the English localization"

    def slurp
      if File.exists? 'app'
        string_regex = []
        Dir.glob('app/**/*.rb') do |ruby_file|
          File.open(ruby_file).each do |line|
            next unless line =~ /"([^"]+)"\._/ or line =~ /'([^']+)'\._/
            string_regex += line.scan(/"([^"]+)"\._/)
            string_regex += line.scan(/'([^']+)'\._/)
          end
        end
        FileUtils.mkdir('resources') unless File.exists?('resources')
        FileUtils.mkdir('resources/en.lproj') unless File.exists?('resources/en.lproj')
        localizable = 'resources/en.lproj/Localizable.strings'
        system("touch #{localizable}")
        string_regex.flatten!
        count = 0
        string_regex.each do |string|
          unless File.open(localizable).read =~ /"#{Regexp.quote(string)}"\s*=\s*"#{Regexp.quote(string)}";/
            count += 1 
            File.open(localizable, 'a+') { |f| f.write("\"#{string}\" = \"#{string}\";\n") }
          end
        end
        if count > 0
          puts "#{count} new string#{count == 1 ? '' : 's'} entered into ./resources/en.lproj/Localizable.strings"
        else
          puts "No new strings added."
        end
      else
        abort "Error: 'app' folder not found. Are you running Locamotion in a RubyMotion project?"
      end
    end

    desc "generate", "Generate the other language's strings based on that of the english localization"

    def generate
      if File.exists? 'resources'
        # Go through each English .strings file
        Dir.glob('resources/en.lproj/*.strings') do |strings_file|
          # Go through the other localized folders
          # except for the English one
          Dir.glob('resources/*.lproj') do |folder|
            next if folder == 'resources/en.lproj'
            # Get each string from the English localized file
            count = 0
            localized_strings_file = File.join(folder, File.basename(strings_file))
            File.open(strings_file).each do |line|
              string_regex = line[/(".*"\s*=\s*".*";)/, 1]
              next unless string_regex
              string = string_regex[/(".*")\s*=/, 1]
              # Create the new localized strings file if it doesn't exist,
              # and add the string if its non-localized version is not preset
              system("touch #{localized_strings_file}")
              unless File.open(localized_strings_file).read =~ /#{Regexp.quote(string)}\s*=\s*".*";/
                count += 1
                File.open(localized_strings_file, 'a+') { |f| f.write("#{string} = #{string};\n") }
              end
            end
            if count > 0
              puts "#{count} new string#{count == 1 ? '' : 's'} entered into #{localized_strings_file}"
            else
              puts "No new strings added to #{localized_strings_file}."
            end
          end
        end
      else
        abort "Error: 'resources' folder not found. Are you running Locamotion in a RubyMotion project?"
      end
    end
  end
end

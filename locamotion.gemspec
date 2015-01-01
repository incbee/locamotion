# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: locamotion 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "locamotion"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ramon Huidobro"]
  s.date = "2014-12-26"
  s.description = "Locamotion (Localization Motion) is a Command Line tool to generate localizable files in RubyMotion projects. It parses the 'app' directory for SugarCube (https://github.com/rubymotion/sugarcube) strings, ending in '._'. It also transfers the english localized files into others."
  s.email = "ramon.martin.huidobro@gmail.com"
  s.executables = ["locamotion"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/locamotion",
    "features/generate.feature",
    "features/slurp.feature",
    "features/step_definitions/locamotion_steps.rb",
    "features/support/env.rb",
    "lib/locamotion.rb",
    "lib/locamotion/app.rb",
    "lib/locamotion/runner.rb",
    "spec/app_spec.rb",
    "spec/generate_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/incbee/locamotion"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "CLI tool to generate localizable files in RubyMotion projects"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thor>, ["~> 0"])
      s.add_development_dependency(%q<aruba>, ["~> 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.1.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<thor>, ["~> 0"])
      s.add_dependency(%q<aruba>, ["~> 0"])
      s.add_dependency(%q<rspec>, ["~> 3.1.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<thor>, ["~> 0"])
    s.add_dependency(%q<aruba>, ["~> 0"])
    s.add_dependency(%q<rspec>, ["~> 3.1.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

# locamotion

Locamotion is a helper tool for automating localizing RubyMotion apps using [SugarCube localized](https://github.com/rubymotion/sugarcube).

## Installation
  gem install locamotion

## Usage

Locamotion has two commands to be run in any RubyMotion project folder:

### locamotion slurp

With slurp, Locamotion will go through the _app_ directory of the RubyMotion project and find all localized strings. These are declared with Sugarcube as follows:

  "I am a localized string"._

Locamotion will then look in the _resources/en.lproj/Localizable.strings_ file, create it if it doesn't exist, and then add the strings that are missing from it.

### locamotion generate

With generate, Locamotion will go through the strings inside each localizable file in the English _resources/en.lproj_ localization folder, and place them in each available localization folder for another language, that is: _resources/<language_code>.lproj_.


## Contributing to locamotion
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Incredible Bee Ltd. See LICENSE.txt for
further details.


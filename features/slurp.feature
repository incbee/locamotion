Feature: Locamotion slurp
  In order to automate English localization in RubyMotion apps
  As a user
  I should be able to use locamotion to slurp English strings


  Background:

    In order to slurp and/or generate localization strings, users
    should have a RubyMotion project with some ruby files.

    Given a file named "rm-project/app/test.rb" with:
      """
      puts "I am localized!"._
      string = "I am also localized."._
      """
    And a file named "rm-project/app/test2.rb" with:
      """
      value = 3
      string = "I am localized with a value of #{value}."._
      field = NSString.dateTimeFieldWithVariable('filename', label: 'Filename'._)
      """
    And a file named "rm-project/app/test3.rb" with:
      """
      array = ['first string'._, 'second string'._, 'third string'._]
      """
    When I cd to "rm-project"

  Scenario: Slurp with english files

    To slurp, the user has to call "locamotion slurp"

    When I run `locamotion slurp`
    Then the output should contain "7 new strings"
    And the file "resources/en.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am also localized." = "I am also localized.";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      "Filename" = "Filename";
      "first string" = "first string";
      "second string" = "second string";
      "third string" = "third string";
      """

  Scenario: Slurp with existing english files

    Users can add missing strings to their english file.

    Given a file named "resources/en.lproj/Localizable.strings" with:
    """
    "Filename" = "Filename";
    "I am localized!" = "I am localized!";
    """
    When I run `locamotion slurp`
    Then the output should contain "5 new strings"
    And the file "resources/en.lproj/Localizable.strings" should contain:
    """
    "I am also localized." = "I am also localized.";
    "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
    "first string" = "first string";
    "second string" = "second string";
    "third string" = "third string";
    """

  Scenario: Slurp with all existing english strings

    Locamotion should not add strings that already exist.

    Given a file named "resources/en.lproj/Localizable.strings" with:
    """
    "I am localized!" = "I am localized!";
    "I am also localized." = "I am also localized.";
    "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
    "Filename" = "Filename";
    "first string" = "first string";
    "second string" = "second string";
    "third string" = "third string";
    """
    When I run `locamotion slurp`
    Then the output should contain "No new strings"
    And the file "resources/en.lproj/Localizable.strings" should contain:
    """
    "I am localized!" = "I am localized!";
    "I am also localized." = "I am also localized.";
    "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
    "Filename" = "Filename";
    "first string" = "first string";
    "second string" = "second string";
    "third string" = "third string";
    """

  Scenario: Attempt to run Locamotion where there's no RubyMotion project

    Users should be informed that they're trying to run Locamotion outside
    of a RubyMotion project, which won't work.

    When I cd to "../"
    And I run `locamotion slurp`
    Then the stderr should contain "Error: 'app' folder not found. Are you running Locamotion in a RubyMotion project?"

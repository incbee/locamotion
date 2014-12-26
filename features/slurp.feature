Feature: Locamotion
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
      """
    When I cd to "rm-project"

  Scenario: Slurp with english files

    To slurp, the user has to call "locamotion slurp"

    When I run `locamotion slurp`
    Then the output should contain "3 new strings"
    And the file "resources/en.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am also localized." = "I am also localized.";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      """
  
  Scenario: Slurp with existing english files

    Users can add missing strings to their english file.

    Given a file named "resources/en.lproj/Localizable.strings" with:
    """
    "I am localized!" = "I am localized!";
    """
    When I run `locamotion slurp`
    Then the output should contain "2 new strings"
    And the file "resources/en.lproj/Localizable.strings" should contain:
    """
    "I am also localized." = "I am also localized.";
    "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
    """

  Scenario: Slurp with all existing english strings

    Locamotion should not add strings that already exist.

    Given a file named "resources/en.lproj/Localizable.strings" with:
    """
    "I am localized!" = "I am localized!";
    "I am also localized." = "I am also localized.";
    "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
    """
    When I run `locamotion slurp`
    Then the output should contain "No new strings"
    And the file "resources/en.lproj/Localizable.strings" should contain:
    """
    "I am localized!" = "I am localized!";
    "I am also localized." = "I am also localized.";
    "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
    """

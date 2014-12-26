Feature: Locamotion
  In order to automate localization of RubyMotion apps
  As a user
  I should be able to use locamotion to slurp and generate localizable strings


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

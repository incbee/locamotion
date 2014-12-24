Feature: Locamotion
  In order to automate localization of RubyMotion apps
  As a user
  I should be able to use locamotion to slurp and generate localizable strings


  Background:

    In order to slurp and/or generate localization strings, users
    should have a RubyMotion project with some ruby files.

    Given a file named 'app/test.rb' with:
      """
      puts "I am localized!"._
      string = 'I am also localized."._
      """

  Scenario: Slurp with english files

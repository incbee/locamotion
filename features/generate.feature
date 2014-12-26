Feature: Locamotion
  In order to automate localization in RubyMotion apps for languages other than English
  As a user
  I should be able to use locamotion to generate strings


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
    And a file named "rm-project/resources/en.lproj/Localizable.strings" with:
    """
    "I am localized!" = "I am localized!";
    "I am also localized." = "I am also localized.";
    "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
    """
    Given a directory named "rm-project/resources/es.lproj"
    When I cd to "rm-project"


  Scenario: Generate Spanish strings

    Users can generate strings for other existing localizations
    from the English ones using 'locamotion generate'

    When I run `locamotion generate`
    Then the output should contain "3 new strings"
    And the file "resources/es.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am also localized." = "I am also localized.";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      """

  Scenario: Generate Spanish and German strings

    Users can generate strings for several existing localizations
    from the English ones using 'locamotion generate'

    Given a directory named "resources/de.lproj"
    When I run `locamotion generate`
    Then the output should contain "3 new strings entered into resources/de.lproj/Localizable.strings"
    Then the output should contain "3 new strings entered into resources/es.lproj/Localizable.strings"
    And the file "resources/es.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am also localized." = "I am also localized.";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      """
    And the file "resources/de.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am also localized." = "I am also localized.";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      """

  Scenario: Generate Spanish and German strings with some taken strings

    Users can generate strings for several existing localizations
    from the English ones using 'locamotion generate'

    Given a directory named "resources/de.lproj"
    Given a file named "resources/es.lproj/Localizable.strings" with:
    """
    "I am localized!" = "Tengo traduccion!";
    "I am also localized." = "Yo tambien tengo traduccion.";
    """
    Given a file named "resources/de.lproj/Localizable.strings" with:
    """
    "I am also localized." = "Ich bin auch übersetzt.";
    """
    When I run `locamotion generate`
    Then the output should contain "2 new strings entered into resources/de.lproj/Localizable.strings"
    Then the output should contain "1 new string entered into resources/es.lproj/Localizable.strings"
    And the file "resources/es.lproj/Localizable.strings" should contain:
      """
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      """
    And the file "resources/de.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      """

Feature: Locamotion generate
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
      item.title = NSString.stringWithFormat("Export All Contents in "%@"…"._, object.name)
      """
    And a file named "rm-project/resources/en.lproj/Localizable.strings" with:
    """
    "I am localized!" = "I am localized!";
    "I am also localized." = "I am also localized.";
    "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
    "Export All Contents in "%@"…" = "Export All Contents in "%@"…";
    """
    Given a directory named "rm-project/resources/es.lproj"
    When I cd to "rm-project"


  Scenario: Generate Spanish strings

    Users can generate strings for other existing localizations
    from the English ones using 'locamotion generate'

    When I run `locamotion generate`
    Then the output should contain "4 new strings"
    And the file "resources/es.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am also localized." = "I am also localized.";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      "Export All Contents in "%@"…" = "Export All Contents in "%@"…";
      """

  Scenario: Generate Spanish and German strings

    Users can generate strings for several existing localizations
    from the English ones using 'locamotion generate'

    Given a directory named "resources/de.lproj"
    When I run `locamotion generate`
    Then the output should contain "4 new strings entered into resources/de.lproj/Localizable.strings"
    Then the output should contain "4 new strings entered into resources/es.lproj/Localizable.strings"
    And the file "resources/es.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am also localized." = "I am also localized.";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      "Export All Contents in "%@"…" = "Export All Contents in "%@"…";
      """
    And the file "resources/de.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am also localized." = "I am also localized.";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      "Export All Contents in "%@"…" = "Export All Contents in "%@"…";
      """

  Scenario: Generate Spanish and German strings with some taken strings

    Users can generate missing strings for several existing localizations
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
    Then the output should contain "3 new strings entered into resources/de.lproj/Localizable.strings"
    Then the output should contain "2 new strings entered into resources/es.lproj/Localizable.strings"
    And the file "resources/es.lproj/Localizable.strings" should contain:
      """
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      "Export All Contents in "%@"…" = "Export All Contents in "%@"…";
      """
    And the file "resources/de.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "I am localized!";
      "I am localized with a value of #{value}." = "I am localized with a value of #{value}.";
      "Export All Contents in "%@"…" = "Export All Contents in "%@"…";
      """

  Scenario: Generate Spanish and German strings with all taken strings

    Users can attempt to generate strings for existing localizations,
    even though these are all taken.

    Given a directory named "resources/de.lproj"
    Given a file named "resources/es.lproj/Localizable.strings" with:
    """
    "I am localized!" = "Tengo traduccion!";
    "I am also localized." = "Yo tambien tengo traduccion.";
    "I am localized with a value of #{value}." = "Tengo traduccion con el valor #{value}.";
    "Export All Contents in "%@"…" = "Exportar contenidos de "%@"…";
    """
    Given a file named "resources/de.lproj/Localizable.strings" with:
    """
    "I am localized!" = "Ich bin übersetzt!";
    "I am also localized." = "Ich bin auch übersetzt.";
    "I am localized with a value of #{value}." = "Ich bin mit den wert #{value} übersetzt.";
    "Export All Contents in "%@"…" = "Inhalt von "%@" exportieren…";
    """
    When I run `locamotion generate`
    Then the output should contain "No new strings added to resources/de.lproj/Localizable.strings"
    Then the output should contain "No new strings added to resources/es.lproj/Localizable.strings"
    And the file "resources/es.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "Tengo traduccion!";
      "I am also localized." = "Yo tambien tengo traduccion.";
      "I am localized with a value of #{value}." = "Tengo traduccion con el valor #{value}.";
      "Export All Contents in "%@"…" = "Exportar contenidos de "%@"…";
      """
    And the file "resources/de.lproj/Localizable.strings" should contain:
      """
      "I am localized!" = "Ich bin übersetzt!";
      "I am also localized." = "Ich bin auch übersetzt.";
      "I am localized with a value of #{value}." = "Ich bin mit den wert #{value} übersetzt.";
      "Export All Contents in "%@"…" = "Inhalt von "%@" exportieren…";
      """

  Scenario: Attempt to run Locamotion where there's no RubyMotion project

    Users should be informed that they're trying to run Locamotion outside
    of a RubyMotion project, which won't work.

    When I cd to "../"
    And I run `locamotion generate`
    Then the stderr should contain "Error: 'resources' folder not found. Are you running Locamotion in a RubyMotion project?"

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "generate" do
  before do
    @app = Locamotion::App.new
  end

  it "announces 3 german strings" do
    expect(@app.announce_generate_results(3, '/tmp/rm_project/resources/de.lproj/Localizable.strings')).to eq("3 new strings entered into /tmp/rm_project/resources/de.lproj/Localizable.strings")
  end

  it "announces 1 german strings" do
    expect(@app.announce_generate_results(1, '/tmp/rm_project/resources/de.lproj/Localizable.strings')).to eq("1 new string entered into /tmp/rm_project/resources/de.lproj/Localizable.strings")
  end

  it "announces no german strings" do
    expect(@app.announce_generate_results(0, '/tmp/rm_project/resources/de.lproj/Localizable.strings')).to eq("No new strings added to /tmp/rm_project/resources/de.lproj/Localizable.strings.")
  end
end

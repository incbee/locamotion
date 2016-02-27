require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Slurp" do
  before do
    FileUtils.rm_rf('/tmp/rm_project') if File.exist?('/tmp/rm_project')
    FileUtils.mkdir_p('/tmp/rm_project/app')
    content = <<-eos
    "I am localized!"._
    "I am also localized."._
    "Export \"%@\" Object…"._
    eos
    File.open('/tmp/rm_project/app/test1.rb', 'a+') { |f| f.write(content) }
    File.open('/tmp/rm_project/app/test2.rb', 'a+') { |f| f.write("\"I am to be localized\"._") }
    @app = Locamotion::App.new 
  end

  after do
    FileUtils.rm_rf('/tmp/rm_project')
  end

  it "gets all localizable strings" do
    expect(@app.parse_rubymotion_app('/tmp/rm_project/app/**/*.rb')).to match_array(["I am localized!", "I am also localized.", "I am to be localized", "Export \"%@\" Object…"])
  end

  it "announces 4 finished strings" do
    expect(@app.announce_slurp_results(4)).to eq("4 new strings entered into resources/en.lproj/Localizable.strings")
  end

  it "announces 1 finished string" do
    expect(@app.announce_slurp_results(1)).to eq("1 new string entered into resources/en.lproj/Localizable.strings")
  end

  it "announces no finished strings" do
    expect(@app.announce_slurp_results(0)).to eq("No new strings added.")
  end

end

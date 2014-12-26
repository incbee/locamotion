require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Locamotion" do
  before do
    FileUtils.rm_rf('/tmp/rm_project')
    FileUtils.mkdir_p('/tmp/rm_project/app')
    content = <<-eos
    "I am localized!"._
    "I am also localized."._
    eos
    File.open('/tmp/rm_project/app/test1.rb', 'a+') { |f| f.write(content) }
    File.open('/tmp/rm_project/app/test2.rb', 'a+') { |f| f.write("\"I am to be localized\"._") }
    @app = Locamotion::App.new 
  end

  describe "slurp" do
    it "gets all localizable strings" do
      expect(@app.parse_rubymotion_app('/tmp/rm_project/app/**/*.rb')).to match_array(["I am localized!", "I am also localized.", "I am to be localized"])
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "LogoGrabber" do
  it "should find images marked as logos" do
    doc = Nokogiri::HTML("<html><body><img src='something.jpg' alt='our logo'/><img src='logo.png'/></body>")
    LogoGrabber.grab_from_doc(doc).count.should == 2
  end
  it "should find one image marked as logos with single option" do
    doc = Nokogiri::HTML("<html><body><img src='something.jpg' alt='our logo'/><img src='logo.png'/></body>")
    LogoGrabber.grab_from_doc(doc, :single => true).count.should == 1
  end

  it "should not find images that aren't marked as logos" do
    doc = Nokogiri::HTML("<html><body><img src='something.jpg' alt='not our l1go'/></body>")
    LogoGrabber.grab_from_doc(doc).count.should == 0
  end

end

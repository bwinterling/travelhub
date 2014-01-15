require 'spec_helper'

describe "Tripsters"  do
  context "as a trip owner" do
    it "can invite a tripster from the show page, and sends tweet"
    it "can see whether invited tripsters have registered"
    it "can remove a tripster from the trip"
  end
  context "as an invited tripster" do
    it "can authenticate with twitter"
    it "once authenticated, can see invited trip on dashboard"
    it "cannot edit trip details"
  end
end

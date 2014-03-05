require 'spec_helper'

describe SmartCookbook do
  before :each do
    @smart_cookbook = SmartCookbook.new
  end
  it "freezes himself at initialization" do
    expect(@smart_cookbook.frozen?).to be_true
  end

  describe "#decorator_class" do
    it "is CookbookDecorator" do
      expect(@smart_cookbook.decorator_class).to eq(CookbookDecorator)
    end
  end

end
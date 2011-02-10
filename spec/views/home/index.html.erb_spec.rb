require 'spec_helper'

describe "home/index.html.erb" do
  
  it "displays a url form" do
    render
    
    rendered.should contain("shorten a url")
  end
end

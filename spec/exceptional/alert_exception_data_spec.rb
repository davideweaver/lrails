require File.dirname(__FILE__) + '/../spec_helper'

describe Exceptional::AlertData do
  it "raises error" do
    data = Exceptional::AlertData.new(Exceptional::Alert.new("A string"), "Alert")
    result_json = JSON.parse(data.to_json)
    result_json['rescue_block']['name'].should == 'Alert'
    result_json['exception']['message'].should == "A string"
    result_json['exception']['exception_class'].should == 'Exceptional::Alert'
  end
end

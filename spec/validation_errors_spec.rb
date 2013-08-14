require_relative '../lib/ValidationErrors'

describe ValidationErrors do
  ERRORS = ["Bad address", "Bad price"]
  LINE_NUMBER = 10
  LINE_CONTENTS = "item1, item2, item3"
  let(:e){ ValidationErrors.new(:errors => ERRORS,
                                :line_number => LINE_NUMBER,
                                :line_contents => LINE_CONTENTS)
  }

  it 'has error messages' do
    e.error_messages.should == ERRORS
  end

  it "has a line number for the error" do
    e.line_number.should == LINE_NUMBER
  end

  it "contains the content of the error line" do
    e.line_contents.should == LINE_CONTENTS
  end

  it "can dump its contents" do
    e.dump.should_not be_empty
  end
end


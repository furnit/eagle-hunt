require 'rspec/expectations'

RSpec::Matchers.define :be_invalid_for do |attrib|
  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base) 
    subject.valid?
    # there might be other errors for the attribute too!
    expect(subject.errors[attrib].size).to be > 0
  end
end

RSpec::Matchers.define :be_valid_for do |attrib|
  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base) 
    subject.valid?
    expect(subject.errors[attrib].size).to eq(0)
  end
end
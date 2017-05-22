require 'rspec/expectations'

RSpec::Matchers.define :valid do
  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base) 
    subject.valid?
    expect(subject.errors.details.length).to eq 0
  end

  failure_message do |subject|
    "expected no errors on `#{subject.to_s}`, but but #{subject.errors.details.length} error#{subject.errors.details.length > 1 ? 's' : ''}!"
  end
end

RSpec::Matchers.define :be_invalid_on do |attrib|
  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base) 
    subject.valid?
    # there might be other errors for the attribute too!
    expect(subject.errors[attrib].size).to be > 0
  end

  failure_message do |subject|
    "expected some errors on `#{attrib}`, but no error exists!"
  end
end

RSpec::Matchers.define :be_valid_on do |attrib|
  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base) 
    subject.valid?
    expect(subject.errors[attrib].size).to eq 0
  end

  failure_message do |subject|
    "expected no error on `#{attrib}`, but got #{subject.errors[attrib].size} error#{subject.errors[attrib].size > 1 ? 's' : ''}!"
  end
end

RSpec::Matchers.define :have_errors_on do |attrib, errors:|
  errors = [errors].flatten

  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base) 
    subject.valid?1
    # check the error types
    expect(subject.errors.details[attrib].map { |e| e[:error] }).to include(*errors)
  end

  failure_message do |subject|
    "expected errors of `#{errors}` on `#{attrib}`, but got `#{subject.errors.details[attrib].map { |e| e[:error] }}`!"
  end
end
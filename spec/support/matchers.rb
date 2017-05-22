require 'rspec/expectations'

RSpec::Matchers.define :valid do
  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base)
    subject.valid?
    expect(subject.errors.details.length).to eq 0
  end

  failure_message do |subject|
    "expected no errors on `#{subject.to_s}`, but got #{subject.errors.details[attrib].map { |e| e[:error] }} errors!"
  end
end

RSpec::Matchers.define :be_invalid_on do |attrib|
  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base)
    subject.valid?
    # there might be other errors for the attribute too!
    expect(subject.errors[attrib].size).to be > 0
    # all error message should be translated to persian
    subject.errors[attrib].each { |m| expect(m.is_arabic?).to be_truthy }
  end

  failure_message do |subject|
    "expected some errors on `#{attrib}`, but got `#{subject.errors.details[attrib].map { |e| e[:error] }}` errors and/or was not in persian language!"
  end
end

RSpec::Matchers.define :be_valid_on do |attrib|
  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base)
    subject.valid?
    expect(subject.errors[attrib].size).to eq 0
  end

  failure_message do |subject|
    "expected no error on `#{attrib}`, but got #{subject.errors.details[attrib].map { |e| e[:error] }} errors!"
  end
end

RSpec::Matchers.define :have_errors_on do |attrib, errors:|
  errors = [errors].flatten

  match do |subject|
    raise RuntimeError.new("expecting the subject be an `ActiveRecord::Base` instance, but got `#{subject.class}`") if not subject.is_a?(ActiveRecord::Base)
    subject.valid?
    # check the error types
    expect(subject.errors.details[attrib].map { |e| e[:error] }).to include(*errors)
    # all error message should be translated to persian
    subject.errors[attrib].each { |m| expect(m.is_arabic?).to be_truthy }
  end

  failure_message do |subject|
    "expected errors of `#{errors}` on `#{attrib}`, but got `#{subject.errors.details[attrib].map { |e| e[:error] }}` and/or was not in persian language!"
  end
end
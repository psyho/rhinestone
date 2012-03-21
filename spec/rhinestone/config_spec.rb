require_relative '../spec_helper'

describe Rhinestone::Config do
  it "parses out cache_path from arguments in long version" do
    config('-d --environment prod --cache-path /some/path -p 80').should == {
      :cache_path => '/some/path'
    }
  end

  it "parses out cache_path from arguments in short version" do
    config('-d --environment prod -C /some/path -p 80').should == {
      :cache_path => '/some/path'
    }
  end

  it 'removes the option from argv' do
    args = argv('-p --cache-path /foo -D')

    Rhinestone::Config.new(args).to_h

    args.should == ['-p', '-D']
  end

  def config(command_line)
    Rhinestone::Config.new(argv(command_line)).to_h
  end

  def argv(command_line)
    command_line.split(' ')
  end
end

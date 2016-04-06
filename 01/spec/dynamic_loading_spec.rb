require_relative 'spec_helper'
require_relative '../page/dynamic_loading'

describe 'Dynamic Loading' do

  before(:each) do
    @dynamic_loading = DynamicLoading.new(@driver, @eyes)
  end

  it 'display hidden element' do
    @dynamic_loading.load_example(1)
  end

  it 'render missing element' do
    @dynamic_loading.load_example(2)
  end

end

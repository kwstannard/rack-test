require_relative 'fib_lobster'

describe FibLobster do
  let(:app) { double(call: [nil,{}, ["test"]]) }
  describe "#call" do
    subject { described_class.new(app).call(env) }

    context 'path is /1' do
      let(:env) { {'PATH_INFO' => '/1'} }
      it{ is_expected.to eq [nil,{'Content-Length' => '4'}, ['1111']] }
    end

    context 'path is /5' do
      let(:env) { {'PATH_INFO' => '/5'} }
      it{ is_expected.to eq [nil,{'Content-Length' => '4'}, ['8888']] }
    end
  end
end

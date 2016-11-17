require 'spec_helper'

describe OmniAuth::Strategies::Yoti do
  subject do
    client_options = {
      client_options: {
        application_id: 'application_id',
        client_sdk_id: 'client_sdk_id',
        key_file_path: 'spec/fixtures/ruby-sdk-test.pem'
      }
    }

    OmniAuth::Strategies::Yoti.new(nil, client_options)
  end

  before do
    allow(subject).to receive(:token).and_return(File.read('spec/fixtures/encrypted_yoti_token.txt', encoding: 'utf-8'))
  end

  describe 'client options' do
    it 'has the correct application_id' do
      expect(subject.options.client_options[:application_id]).to eq('application_id')
    end

    it 'has the correct client_sdk_id' do
      expect(subject.options.client_options[:client_sdk_id]).to eq('client_sdk_id')
    end

    it 'has the correct key_file_path' do
      expect(subject.options.client_options[:key_file_path]).to eq('spec/fixtures/ruby-sdk-test.pem')
    end
  end

  describe '#request_phase' do
    it 'redirects to the connect URL' do
      connect_url = "https://www.yoti.com/connect/#{subject.options.client_options[:application_id]}"
      expect(subject).to receive(:redirect).with(connect_url)
      subject.request_phase
    end
  end

  describe '#uid' do
    it 'returns the yoti_user_id' do
      expect(subject.uid).to eql('Hig2yAT79cWvseSuXcIuCLa5lNkAPy70rxetUaeHlTJGmiwc/g1MWdYWYrexWvPU')
    end
  end

  describe '#info' do
    it 'returns an info array' do
      expect(subject.info).to eql(name: 'Hig2yAT79cWvseSuXcIuCLa5lNkAPy70rxetUaeHlTJGmiwc/g1MWdYWYrexWvPU')
    end
  end

  describe '#extra' do
    it 'has the correct photo' do
      selfie = File.read('spec/fixtures/selfie.txt', encoding: 'utf-8')
      expect(subject.extra[:photo]).to eql(selfie)
    end

    it 'has the correct phone number' do
      expect(subject.extra[:mobile_number]).to eql('+447474747474')
    end
  end
end

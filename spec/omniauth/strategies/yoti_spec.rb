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
    context 'when using a mock request' do
      it 'has the correct selfie' do
        selfie = File.read('spec/fixtures/selfie.txt', encoding: 'utf-8')
        expect(subject.extra[:selfie]).to eql(selfie)
      end

      it 'has the correct phone number' do
        expect(subject.extra[:phone_number]).to eql('+447474747474')
      end
    end

    context 'when using a mock object' do
      before do
        allow(subject).to receive(:yoti_user_profile).and_return(raw_info_hash)
      end

      it 'has the correct selfie' do
        expect(subject.extra[:selfie]).to eql('selfie.png')
      end

      it 'has the correct given names' do
        expect(subject.extra[:given_names]).to eql('Given Names')
      end

      it 'has the correct family name' do
        expect(subject.extra[:family_name]).to eql('Family Name')
      end

      it 'has the correct mobile number' do
        expect(subject.extra[:phone_number]).to eql('07474747474')
      end

      it 'has the correct email address' do
        expect(subject.extra[:email_address]).to eql('email@domain.com')
      end

      it 'has the correct date of birth' do
        expect(subject.extra[:date_of_birth]).to eql('2000.12.12')
      end

      it 'has the correct postal address' do
        expect(subject.extra[:postal_address]).to eql('WC2N 4JH')
      end

      it 'has the correct gender' do
        expect(subject.extra[:gender]).to eql('male')
      end

      it 'has the correct nationality' do
        expect(subject.extra[:nationality]).to eql('British')
      end
    end
  end

  private

  def raw_info_hash
    {
      'selfie' => 'selfie.png',
      'given_names' => 'Given Names',
      'family_name' => 'Family Name',
      'phone_number' => '07474747474',
      'email_address' => 'email@domain.com',
      'date_of_birth' => '2000.12.12',
      'postal_address' => 'WC2N 4JH',
      'gender' => 'male',
      'nationality' => 'British'
    }
  end
end

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
    context 'when using a mock request' do
      it 'returns the base64_selfie_uri value' do
        selfie = File.read('spec/fixtures/selfie.txt', encoding: 'utf-8')
        expect(subject.info[:base64_selfie_uri]).to eql(selfie)
      end
    end

    context 'when using a mock object' do
      before do
        allow(subject).to receive(:yoti_user_profile).and_return(yoti_user_profile_mock)
        allow(subject).to receive(:base64_selfie_uri).and_return(base64_selfie_uri_mock)
        allow(subject).to receive(:age_verified).and_return(age_verified_mock)
      end

      it 'returns the correct values' do
        expect(subject.info[:name]).to eql('John Doe')
        expect(subject.info[:selfie]).to eql('selfie.png')
        expect(subject.info[:full_name]).to eql('John Doe')
        expect(subject.info[:given_names]).to eql('John')
        expect(subject.info[:family_name]).to eql('Doe')
        expect(subject.info[:phone_number]).to eql('07474747474')
        expect(subject.info[:email_address]).to eql('email@domain.com')
        expect(subject.info[:date_of_birth]).to eql('2000.12.12')
        expect(subject.info[:postal_address]).to eql('WC2N 4JH')
        expect(subject.info[:gender]).to eql('male')
        expect(subject.info[:nationality]).to eql('British')
        expect(subject.info[:base64_selfie_uri]).to eql('data:image/jpeg;base64,/9j/2wCEAAMCAg')
        expect(subject.info[:age_verified]).to eql(true)
      end
    end
  end

  describe '#extra' do
    context 'when using a mock request' do
      it 'has the correct selfie' do
        selfie = File.read('spec/fixtures/selfie.txt', encoding: 'utf-8')
        expect('data:image/jpeg;base64,'.concat(Base64.strict_encode64(subject.extra[:raw_info]['selfie']))).to eql(selfie)
      end

      it 'has the correct phone number' do
        expect(subject.extra[:raw_info]['phone_number']).to eql('+447474747474')
      end
    end

    context 'when using a mock object' do
      before do
        allow(subject).to receive(:yoti_user_profile).and_return(yoti_user_profile_mock)
      end

      it 'returns the correct values' do
        expect(subject.extra[:raw_info]['selfie']).to eql('selfie.png')
        expect(subject.extra[:raw_info]['full_name']).to eql('John Doe')
        expect(subject.extra[:raw_info]['given_names']).to eql('John')
        expect(subject.extra[:raw_info]['family_name']).to eql('Doe')
        expect(subject.extra[:raw_info]['phone_number']).to eql('07474747474')
        expect(subject.extra[:raw_info]['email_address']).to eql('email@domain.com')
        expect(subject.extra[:raw_info]['date_of_birth']).to eql('2000.12.12')
        expect(subject.extra[:raw_info]['postal_address']).to eql('WC2N 4JH')
        expect(subject.extra[:raw_info]['gender']).to eql('male')
        expect(subject.extra[:raw_info]['nationality']).to eql('British')
      end
    end
  end

  private

  def yoti_user_profile_mock
    {
      'selfie' => 'selfie.png',
      'full_name' => 'John Doe',
      'given_names' => 'John',
      'family_name' => 'Doe',
      'phone_number' => '07474747474',
      'email_address' => 'email@domain.com',
      'date_of_birth' => '2000.12.12',
      'postal_address' => 'WC2N 4JH',
      'gender' => 'male',
      'nationality' => 'British'
    }
  end

  def base64_selfie_uri_mock
    'data:image/jpeg;base64,/9j/2wCEAAMCAg'
  end

  def age_verified_mock
    true
  end
end

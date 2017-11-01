# OmniAuth Yoti

This gem contains the Yoti strategy for OmniAuth.

## Before You Begin

You should have already installed OmniAuth into your app. If not, read the [OmniAuth README](https://github.com/omniauth/omniauth) to get started.

Now sign in into the [Yoti dashboard](https://www.yoti.com/dashboard/login) and create an application. Take note of your Application ID and Yoti client SDK ID because that is what your web application will use to authenticate against the Yoti API. Make sure to set a callback URL to `YOUR_SITE/auth/yoti/callback`, and download the pem key.

## Using This Strategy

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-yoti'
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install omniauth-yoti
```

## Configuration

Yoti client initialisation looks like this:

```ruby
require 'omniauth-yoti'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yoti, client_options: {
    application_id: ENV['YOTI_APPLICATION_ID'],
    client_sdk_id: ENV['YOTI_CLIENT_SDK_ID'],
    key_file_path: ENV['YOTI_KEY_FILE_PATH']
  }
end
```

`YOTI_APPLICATION_ID` -  found on the *Integrations* settings page, under the Login button section.

`YOTI_CLIENT_SDK_ID` - found on the *Integrations* settings page.

`YOTI_KEY_FILE_PATH` - the full path to your security key downloaded from the *Keys* settings page (e.g. /Users/developer/access-security.pem).

If you don't have access to the file system to store the pem file, you can replace `key_file_path` with `key`, that stores a string with the content of the secret key (`key: "-----BEGIN RSA PRIVATE KEY-----\nMIIEp..."`).

The configuration values are documented in the [Yoti gem repository](https://github.com/getyoti/ruby#configuration).

## Authentication

A call to `/auth/yoti/callback` will open the Yoti authentication page, and after a successful authentication, you will be redirected to the callback URL from your Yoti dashboard. The auth hash will be available in `request.env['omniauth.auth']`:

```ruby
{
  "provider" => "yoti",
  "uid" => "mHvpV4...",
  "info" => {
              "name" => "mHvpV4Mm+yMb...",
              "base64_selfie_uri" => "data:image/jpeg;base64,/9j/2wCEAAMCAg..."
            },
  "credentials" => {},
  "extra" => {
               "selfie" => "jpeg image file",
               "given_names" => "Given Name",
               "family_name" => "Family Name",
               "phone_number" => "07474747474",
               "email_address" => "email@example.com",
               "date_of_birth" => nil,
               "postal_address" => nil,
               "gender" => 'MALE',
               "nationality" => nil
             }
}

```

# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2018-03-09
### Added
- `age_verified` returns a boolean value of the age validation

### Changed
- Porfile attributes in the response Hash moved from `extra` to `info`. Please check [README.md](README.md#upgrading-from-version-11) for details

## [1.1.3] - 2017-11-01
### Added
- `base64_selfie_uri` value

## [1.1.2] - 2017-10-18

## [1.1.1] - 2017-09-13
### Changed
- Switched from proprietary to MIT license

### Updated dependencies
- `rake` `~> 12.1`
- `rspec` `~> 3.6`
- `simplecov` `~> 0.15`
- `webmock` `~> 3.0`

## [1.1.0] - 2017-04-11
Updates dependencies to the latest versions and aligns extra fields naming conventions with the Yoti attributes.

### Added
- `email_address` field

### Changed
- renamed `photo` to `selfie`
- renamed `mobile_number` to `phone_number`
- renamed `address` to `postal_address`

### Updated dependencies
- Required Ruby version `>= 2.1.9`
- `omniauth` `~> 1.6`
- `rake` `~> 12.0`
- `rspec` `~> 3.5`
- `simplecov` `~> 0.14`
- `webmock` `~> 2.3`

## [1.0.1] - 2016-11-28
### Added
- Yoti proprietary license

## [1.0.0] - 2016-11-25
### Added
- This is an initial public release.

# ProvisionUtil 

[![fastlane Plugin Badge]
(https://img.shields.io/gem/v/provision_util.svg?style=flat)]
(https://rubygems.org/gems/provision_util)


Little library to working with provision profiles and certificates easier 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'provision_util'
```


Or install it yourself as:

    $ gem install provision_util

## Usage

All methods working with both uuid and provision path

Reading provision content into ruby Hash

    requare 'provision_util'
    
    uuid = 'your provision profile uuid'
    custom_path = "provisions/some_uuid.mobileprovision"
    
    # Hash of provision plist
    content = get_provision_content_plist(uuid)
    
    content = get_provision_content_plist(custom_path)
    puts content['AppIDName']
    
Get public key of certificate from provision profile. It's used to sign apps

    # OpenSSL::X509::Certificate 
    cert = get_cert_from_provision(uuid)
    puts cert.subject
    
    path_p12 = "cert.p12"
    password_p12 = "secure123"
    
Compare provision public key with public key from local p12 file

    is_valid = check_public_key(uuid, path_p12, password_p12)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


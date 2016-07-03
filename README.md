# ProvisionUtil
[![fastlane Plugin Badge]
(https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)]
(https://rubygems.org/gems/provision_util)

Little library to make validation of provision profile easier 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'provision_util'
```


Or install it yourself as:

    $ gem install provision_util

## Usage

    requare 'provision_util'
    
    uuid = 'your provision profile uuid'
    
    # Hash of provision plist
    content = ProvisionUtil::get_provision_content_plist(uuid)
    puts content['AppIDName']
    
    # OpenSSL::X509::Certificate which was used to sign provision
    cert = get_cert_from_provision(uuid)
    puts cert.subject
    
    path_p12 = "cert.p12"
    password_p12 = "secure123"
    
    # compare provision public key  with public key from local p12 file
    is_valid = check_public_key(uuid, path_p12, password_p12)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


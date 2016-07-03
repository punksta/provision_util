require 'provision_util'

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
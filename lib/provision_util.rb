require 'provision_util/version'
require 'openssl'
require 'open3'
require 'plist'

module ProvisionUtil
  PROVISIONS = "#{Dir.home}/Library/MobileDevice/Provisioning\ Profiles/".freeze
  CERT_STORE = OpenSSL::X509::Store.new.freeze
  private_constant :CERT_STORE

  # Returns path if argument is path or use it
  # as uuid of provision in Provisioning\ Profiles dir
  def self.get_provision_path(uuid_or_path)
    if File.file?(uuid_or_path)
      return uuid_or_path
    else
      path = File.join PROVISIONS, "#{uuid_or_path}.mobileprovision"
      if not File.file?(path)
        raise "Cant find provision #{uuid_or_path} in path #{PROVISIONS}"
      else
        return path
      end
    end
  end

  # returns provision profile data, parsed by Plist
  # @return [Hash]
  def self.get_provision_content_plist(uuid_or_path)
    File.open(get_provision_path(uuid_or_path)) do |data|
      p7 = OpenSSL::PKCS7.new(data)
      p7.verify([], CERT_STORE, nil, OpenSSL::PKCS7::NOVERIFY)
      return Plist.parse_xml(p7.data)
    end
  end


  # returns first certificate declared in provision DeveloperCertificates field
  # @return [OpenSSL::X509::Certificate]
  def self.get_cert_from_provision(uuid_or_path)
    provision_plist = get_provision_content_plist(uuid_or_path)
    cert_data = provision_plist['DeveloperCertificates'][0].string
    cert = OpenSSL::X509::Certificate.new(cert_data)
    return cert
  end

  # returns all certificates declared in provision DeveloperCertificates field
  # @return [Array] of OpenSSL::X509::Certificate
  def self.get_certs_from_provision(uuid_or_path)
    provision_plist = get_provision_content_plist(uuid_or_path)
    certs_data = provision_plist['DeveloperCertificates'].map do |cert_data|
      OpenSSL::X509::Certificate.new(cert_data.string)
    end
    return certs_data
  end


  # Returns true if given public key is stored in p12
  # @return [Boolean]
  # @param [OpenSSL::X509::Certificate] public_key public key to check
  # @param [String] p12_path path to p12 file
  # @param [String] p12_phrase password to p12 file
  def self.check_public_key(public_key, p12_path, p12_phrase)
    cert = OpenSSL::PKCS12.new(File.read(p12_path), p12_phrase)
    return cert.certificate.to_der == public_key.to_der
  end
end
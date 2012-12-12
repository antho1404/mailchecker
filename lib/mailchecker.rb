require 'mailchecker/version'
require 'net/http'
require "uri"

module Mailchecker
  module Rails
    class Engine < ::Rails::Engine
    end
  end

  mattr_accessor :url
  @@url = "http://www.mail-checker.com/check"

  mattr_accessor :token
  @@token = nil

  mattr_accessor :domain
  @@domain = nil

  def self.setup
    yield self
  end

  def self.validate_email email
    params = { email: email, token: Mailchecker.token, domain: Mailchecker.domain, format: :json }

    uri      = URI.parse Mailchecker.url + "?" + params.to_param
    http     = Net::HTTP.new uri.host, uri.port
    request  = Net::HTTP::Get.new uri.request_uri 
    response = http.request request

    case response.code.to_i
      when 200
        nil
      when 422
        I18n.t :wrong_format, scope: [:mailchecker, :errors, :messages], default: 'the format is not valid (abc@example.com)'
      when 502
        I18n.t :wrong_gateway, scope: [:mailchecker, :errors, :messages], default: 'the domain is not responding'
      when 406
        I18n.t :temporary_email, scope: [:mailchecker, :errors, :messages], default: 'this kind of email is not valid (temporary email)'
      when 400
        raise "Some parameters are missing... did you add the right token in the init file or the domain is valid?"
      else
        raise "Please report this issue (probably a lack of a new functionality), the status code is #{response.code}"
    end
  end

  def self.record_validation record, attr_name, value
    error = Mailchecker::validate_email value.to_s
    record.errors.add attr_name, error if error
  end

  module Validations
    def self.mailchecker *attr_names
      options = { on: :save, allow_nil: false, allow_blank: false }
      options.update attr_names.pop if attr_names.last.is_a? Hash

      validates_each(attr_names, options) do |record, attr_name, value|
        Mailchecker.record_validation record, attr_name, value
      end
    end
  end
end

if defined?(ActiveModel)
  class MailCheckerValidator < ActiveModel::EachValidator
    def validate_each record, attr_name, value
      Mailchecker.record_validation record, attr_name, value
    end
  end

  module ActiveModel::Validations::HelperMethods
    def mailchecker *attr_names
      validates_with MailCheckerValidator, _merge_attributes(attr_names)
    end
  end
else
  if defined?(ActiveRecord)
    class ActiveRecord::Base
      extend ValidatesEmailFormatOf::Validations
    end
  end
end

Dir[File.join(File.dirname(__FILE__), "..", "locales", "*.yml")].each do |loc|
  I18n.load_path << loc
end

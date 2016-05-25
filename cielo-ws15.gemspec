lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cielo/ws15/version'

Gem::Specification.new do |spec|
  spec.name          = 'cielo-ws15'
  spec.version       = Cielo::WS15::VERSION
  spec.authors       = ['Cielo']
  spec.email         = ['cieloecommerce@cielo.com.br']
  spec.description   = "Integração com o webservice 1.5 da Cielo"
  spec.summary       = "SDK Webservice 1.5"
  spec.homepage      = 'https://github.com/DeveloperCielo/Webservice-1.5-ruby'
  spec.license       = 'MIT'
  spec.has_rdoc      = 'yard'

  spec.required_ruby_version = '>= 2.0.0'
  spec.require_paths = ['lib']
  spec.files = ["lib/cielo/ws15/authentication.rb",
                "lib/cielo/ws15/authorization.rb",
                "lib/cielo/ws15/authorization_message.rb",
                "lib/cielo/ws15/cancellation.rb",
                "lib/cielo/ws15/cancellation_message.rb",
                "lib/cielo/ws15/capture.rb",
                "lib/cielo/ws15/capture_message.rb",
                "lib/cielo/ws15/holder.rb",
                "lib/cielo/ws15/lr_info.rb",
                "lib/cielo/ws15/lr_infos.yml",
                "lib/cielo/ws15/merchant.rb",
                "lib/cielo/ws15/message.rb",
                "lib/cielo/ws15/order.rb",
                "lib/cielo/ws15/payment_method.rb",
                "lib/cielo/ws15/token.rb",
                "lib/cielo/ws15/token_message.rb",
                "lib/cielo/ws15/transaction.rb",
                "lib/cielo/ws15/transaction_message.rb",
                "lib/cielo/ws15/exception.rb",
                "lib/cielo/ws15/version.rb",
                "lib/cielo/ws15.rb"]

  spec.add_dependency "bundler", "~> 1.6"
  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "uuidtools", "~> 2.1"
  spec.add_development_dependency "yard", "~> 0.8"
end

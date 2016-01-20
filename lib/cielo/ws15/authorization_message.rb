require "nokogiri"
require "cielo/ws15/message"

module Cielo::WS15Message
  class AuthorizationMessage
    include Cielo::WS15Message

    def serialize(transaction)
      builder = Nokogiri::XML::Builder.new(:encoding => "ISO-8859-1") do |xml|
        xml.send("requisicao-autorizacao-tid",
                     "xmlns" => Cielo::WS15::NAMESPACE,
                     "versao" => Cielo::WS15::VERSION,
                     "id" => transaction.order.number) {

            xml.send("tid", transaction.tid)

            Cielo::WS15Message.serialize_dados_ec(xml, transaction.merchant)
        }
      end

      return builder.to_xml
    end

    def unserialize(message, transaction)
      return Cielo::WS15Message.unserialize_transaction(message, transaction)
    end
  end
end

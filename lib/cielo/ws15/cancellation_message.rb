require "nokogiri"
require "cielo/ws15/message"

module Cielo::WS15Message
  class CancellationMessage
    include Cielo::WS15Message

    def serialize(transaction, total = nil)
      builder = Nokogiri::XML::Builder.new(:encoding => "ISO-8859-1") do |xml|
        xml.send("requisicao-cancelamento",
                     "xmlns" => Cielo::WS15::NAMESPACE,
                     "versao" => Cielo::WS15::XML_VERSION,
                     "id" => transaction.order.number) {

            xml.send("tid", transaction.tid)

            Cielo::WS15Message.serialize_dados_ec(xml, transaction.merchant)

            if total != nil
              xml.send("valor", total)
            end
        }
      end

      return builder.to_xml
    end

    def unserialize(message, transaction)
      return Cielo::WS15Message.unserialize_transaction(message, transaction)
    end
  end
end

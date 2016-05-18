require "nokogiri"
require "uuidtools"
require "cielo/ws15/message"

module Cielo::WS15Message
  class TokenMessage
    include Cielo::WS15Message

    def serialize(merchant, holder)
      builder = Nokogiri::XML::Builder.new(:encoding => "ISO-8859-1") do |xml|
        xml.send("requisicao-token",
                     "xmlns" => Cielo::WS15::NAMESPACE,
                     "versao" => Cielo::WS15::XML_VERSION,
                     "id" => UUIDTools::UUID.random_create) {

            Cielo::WS15Message.serialize_dados_ec(xml, merchant)

            xml.send("dados-portador") {
                xml.send("numero", holder.number)
                xml.send("validade", holder.expiration)
                xml.send("indicador", holder.indicator)
                xml.send("codigo-seguranca", holder.cvv)
                xml.send("nome-portador", holder.name)
            }
        }
      end

      return builder.to_xml
    end

    def unserialize(message)
      return Cielo::WS15Message.unserialize_token(message)
    end
  end
end

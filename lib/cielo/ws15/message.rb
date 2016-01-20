require "nokogiri"
require "cielo/ws15/authentication"
require "cielo/ws15/authorization"
require "cielo/ws15/capture"
require "cielo/ws15/cancellation"
require "cielo/ws15/token"

# Helper para serialização e deserialização dos XML de requisição e resposta
module Cielo::WS15Message
  def self.serialize_dados_ec(xml, merchant)
    xml.send("dados-ec") {
      xml.send("numero", merchant.affiliation_id)
      xml.send("chave", merchant.affiliation_key)
    }
  end

  def self.unserialize_transaction(message, transaction)
    document = document = load_document(message)

    check_error(document)

    transaction.tid = document.xpath("//transacao/tid").text
    transaction.pan = document.xpath("//transacao/pan").text

    transaction.order = Cielo::Order.new(
      document.xpath("//transacao/dados-pedido/numero").text,
      document.xpath("//transacao/dados-pedido/valor").text.to_i,
      document.xpath("//transacao/dados-pedido/moeda").text.to_i,
      document.xpath("//transacao/dados-pedido/data-hora").text
    )

    transaction.order.description = document.xpath("//transacao/dados-pedido/descricao").text
    transaction.order.language = document.xpath("//transacao/dados-pedido/idioma").text
    transaction.order.shipping = document.xpath("//transacao/dados-pedido/taxa-embarque").text.to_i

    transaction.payment_method = Cielo::PaymentMethod.new(
      document.xpath("//transacao/forma-pagamento/bandeira").text,
      document.xpath("//transacao/forma-pagamento/produto").text,
      document.xpath("//transacao/forma-pagamento/parcelas").text.to_i
    )

    transaction.authentication = Cielo::Authentication.new
    transaction.authentication.code = document.xpath("//transacao/autenticacao/codigo").text
    transaction.authentication.message = document.xpath("//transacao/autenticacao/mensagem").text
    transaction.authentication.date_time = document.xpath("//transacao/autenticacao/data-hora").text
    transaction.authentication.total = document.xpath("//transacao/autenticacao/valor").text
    transaction.authentication.eci = document.xpath("//transacao/autenticacao/eci").text

    transaction.authorization = Cielo::Authorization.new
    transaction.authorization.code = document.xpath("//transacao/autorizacao/codigo").text
    transaction.authorization.message = document.xpath("//transacao/autorizacao/mensagem").text
    transaction.authorization.date_time = document.xpath("//transacao/autorizacao/data-hora").text
    transaction.authorization.total = document.xpath("//transacao/autorizacao/valor").text
    transaction.authorization.lr = document.xpath("//transacao/autorizacao/lr").text
    transaction.authorization.arp = document.xpath("//transacao/autorizacao/arp").text
    transaction.authorization.nsu = document.xpath("//transacao/autorizacao/nsu").text

    transaction.capture = Cielo::Capture.new
    transaction.capture.code = document.xpath("//transacao/captura/codigo").text
    transaction.capture.message = document.xpath("//transacao/captura/mensagem").text
    transaction.capture.date_time = document.xpath("//transacao/captura/data-hora").text
    transaction.capture.total = document.xpath("//transacao/captura/valor").text

    transaction.cancellation = Array.new

    document.xpath("//transacao/cancelamentos/cancelamento").each do |cancelamento|
      cancellation = Cielo::Cancellation.new

      cancellation.code = cancelamento.xpath('.//codigo').text
      cancellation.message = cancelamento.xpath('.//mensagem').text
      cancellation.date_time = cancelamento.xpath('.//data-hora').text
      cancellation.total = cancelamento.xpath('.//valor').text

      transaction.cancellation << cancellation
    end

    transaction.token = unserialize_token(message, document)

    return transaction
  end

  def self.unserialize_token(message, document = nil)
    if document == nil
      document = load_document(message)
    end

    token = Cielo::Token.new

    token.code = document.xpath(".//token/dados-token/codigo-token").text
    token.status = document.xpath(".//token/dados-token/status").text
    token.number = document.xpath(".//token/dados-token/numero-cartao-truncado").text

    return token
  end

  private
  def self.check_error(document)
    code = document.xpath(".//erro/codigo").text
    message = document.xpath(".//erro/mensagem").text

    raise "Erro[#{code}]: #{message}" unless code == ""
  end

  def self.load_document(message)
    document = Nokogiri::XML(message)
    document.remove_namespaces!

    return document
  end
end

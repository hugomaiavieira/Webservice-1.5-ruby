require "cielo/ws15/holder"
require "cielo/ws15/merchant"
require "cielo/ws15/order"
require "cielo/ws15/payment_method"
require "cielo/ws15/transaction"
require "cielo/ws15/token"

require "cielo/ws15/authorization_message"
require "cielo/ws15/cancellation_message"
require "cielo/ws15/capture_message"
require "cielo/ws15/transaction_message"
require "cielo/ws15/token_message"
require "net/http"

# SDK de integração com o Webservice 1.5 da Cielo
module Cielo
  def self.root_path
    File.dirname __dir__
  end

  # Integração com o Webservice 1.5;  esse participante faz um papel de facilitador
  # para a construção de todos os participantes importantes para a integração.
  # Através de factory methods, é possível criar as instâncias pré-configuradas
  # com os parâmetros mínimos necessários para a execução das operações.
  class WS15
    # Ambiente de produção da Cielo
    PRODUCTION = "https://ecommerce.cielo.com.br/servicos/ecommwsec.do"

    # Ambiente de testes da Cielo
    TEST = "https://qasecommerce.cielo.com.br/servicos/ecommwsec.do"

    # Namespace dos XML de requisição e resposta
    NAMESPACE = "http://ecommerce.cbmp.com.br"

    # Versão do XML utilizado na integração
    XML_VERSION = "1.3.0"

    attr_accessor :merchant, :endpoint
    private :merchant, :endpoint

    # Inicializa uma nova instância de WS15 informando as credenciais e o ambiente
    #
    # @param affiliation_id [String] Número de afiliação na Cielo
    # @param affiliation_key [String] Chave de afiliação
    # @param endpoint [String] Ambiente onde será executada a integração
    def initialize(
      affiliation_id,
      affiliation_key,
      endpoint = WS15::PRODUCTION)

      @merchant = Merchant.new(affiliation_id, affiliation_key)
      @endpoint = endpoint
    end

    # Cria uma instância de Holder, que representa o portador de um cartão,
    # definindo os dados do cartão ou apenas um token previamente gerado
    #
    # @param token_or_number [String] token ou o número do cartão do cliente
    # @param expiration_year [String] ano de expiração do cartão
    # @param expiration_month [String] mês de expiração do cartão
    # @param indicator [Number] indicador de visibilidade do código de segurança
    # @param cvv [String] Código de segurança do cartão
    #
    # @return [Holder] instância configurada com os dados informados
    def holder(
      token_or_number,
      expiration_year = nil,
      expiration_month = nil,
      indicator = nil,
      cvv = Holder::CVV_NOT_INFORMED)

      if expiration_year == nil
        return Holder.new(token_or_number)
      end

      return Holder.new(
        token_or_number,
        expiration_year,
        expiration_month,
        indicator,
        cvv
      )
    end

    # Cria uma instância de Order, que representa um pedido, informando o número
    # valor, moeda e data de criação.
    #
    # @param number [String] Número do pedido na plataforma da loja
    # @param total [Number] Valor total do pedido em centavos
    # @param currency [Number] Código ISO que representa a moeda; 986 para Real
    # @param date_time [String] Data e hora do pedido na plataforma da loja
    #
    # @return [Order] instância de Order configurada com os dados informados
    def order(
      number,
      total,
      currency = 986,
      date_time = nil)

      return Order.new(number, total, currency, date_time)
    end

    # Cria uma instância de PaymentMethod, que representa a forma de pagamento,
    # informando o banco emissor do cartão, produto Cielo e número de parcelas.
    #
    # @param issuer [String] Banco emissor do cartão
    # @param product [String] Produto Cielo que será utilizado
    # @param installments [Number] Número de parcelas; 1 para transação à vista
    #
    # @return [PaymentMethod] instância de PaymentMethod configurada com os dados informados
    def payment_method(
      issuer,
      product = PaymentMethod::CREDITO_A_VISTA,
      installments = 1)

      return PaymentMethod.new(issuer, product, installments)
    end

    # Cria uma instância de Transaction, que representa uma transação, informando
    # o portador do cartão, pedido, forma de pagamento, URL de retorno, método
    # de autorização e forma de captura.
    #
    # @param holder [Holder] Portador do cartão
    # @param order [Order] Pedido
    # @param payment_method [PaymentMethod] Forma de pagamento
    # @param return_url [String] URL de retorno
    # @param authorize [Number] Método de autorização
    # @param capture [Boolean] Se a transação deve ser capturada automaticamente
    #
    # @return [Transaction] instância de Transaction configurada com os dados informados
    def transaction(
      holder,
      order,
      payment_method,
      return_url,
      authorize,
      capture: true)

      return Transaction.new(@merchant, holder, order, payment_method, return_url, authorize, capture:capture)
    end

    # Envia uma requisicao-autorizacao-tid para a Cielo
    #
    # @param transaction [Transaction] A transação que será enviada na requisição
    #
    # @return [Transaction] A transação com o retorno da Cielo
    def authorization_request(transaction)
      authorization_message = WS15Message::AuthorizationMessage.new

      response = send_request(authorization_message.serialize(transaction))

      return transaction
    end

    # Envia uma requisicao-cancelamento para a Cielo
    #
    # @param transaction [Transaction] A transação que será enviada na requisição
    # @param total [Number] O valor que será cancelado; se não informado, o cancelamento será total
    #
    # @return [Transaction] A transação com o retorno da Cielo
    def cancellation_request(transaction, total = nil)
      cancellation_message = WS15Message::CancellationMessage.new

      response = send_request(cancellation_message.serialize(transaction, total))

      return cancellation_message.unserialize(response, transaction)
    end

    # Envia uma requisicao-captura para a Cielo
    #
    # @param transaction [Transaction] A transação que será enviada na requisição
    # @param total [Number] O valor que será capturado; se não informado, a captura será total
    #
    # @return [Transaction] A transação com o retorno da Cielo
    def capture_request(transaction, total = nil)
      capture_message = WS15Message::CaptureMessage.new

      response = send_request(capture_message.serialize(transaction, total))

      return capture_message.unserialize(response, transaction)
    end

    # Envia uma requisicao-token para a Cielo
    #
    # @param holder [Holder] Dados do portador do cartão
    #
    # @return [Token] O token gerado para os dados do cartão
    def token_request(holder)
      token_message = WS15Message::TokenMessage.new

      response = send_request(token_message.serialize(@merchant, holder))

      return token_message.unserialize(response)
    end

    # Envia uma requisicao-transacao para a Cielo
    #
    # @param transaction [Transaction] A transação que será enviada na requisição
    #
    # @return [Transaction] A transação com o retorno da Cielo
    def transaction_request(transaction)
      transaction_message = WS15Message::TransactionMessage.new

      response = send_request(transaction_message.serialize(transaction))

      return transaction_message.unserialize(response, transaction)
    end

    private
    def send_request(message)
      uri = URI(@endpoint)

      response = Net::HTTP.post_form(uri, {"mensagem" => message})

      return response.body
    end
  end
end

module Cielo
  # Representação de uma transação
  #
  # @attr [String] tid ID da transação
  # @attr [String] pan Código PAN da transação
  # @attr [Number] status Código de status da transação
  # @attr [String] authentication_url URL de redirecionamento à Cielo
  # @attr [Authentication] authentication Dados da autenticação
  # @attr [Authorizarion] authorizarion Dados da autorização
  # @attr [Merchant] merchant Dados do estabelecimento comercial
  # @attr [Holder] holder Dados do portador do cartão
  # @attr [Order] order Dados do pedido na plataforma da loja
  # @attr [PaymentMethod] payment_method Dados da forma de pagamento
  # @attr [String] return_url URL de redirecionamento da Cielo para a loja
  # @attr [Number] authorize Método de autorização
  # @attr [Boolean] do_capture Indica se a captura deve ser automática ou não
  # @attr [Capture] capture Dados da captura
  # @attr [String] free_field Campo livre
  # @attr [String] bin Seis primeiros dígitos do cartão
  # @attr [Boolean] generate_token Se um token deve ser gerado para o cartão
  # @attr [String] avs Bloco XML contendo informações necessárias para realizar a consulta ao serviço
  # @attr [Token] token Dados do token
  # @attr [Array<Cancellation>] cancellation Lista de cancelamentos ocorridos
  class Transaction
    # Apenas autentica a transação
    ONLY_AUTHENTICATE = 0

    # Autoriza a transação apenas se tiver sido autenticada
    AUTHORIZE_IF_AUTHENTICATED = 1

    # Autoriza a transação
    AUTHORIZE = 2

    # Autorização direta, sem autenticação
    AUTHORIZE_WITHOUT_AUTHENTICATION = 3

    # Autorização para recorrência
    RECURRENCE = 4

    attr_accessor :tid,
                  :pan,
                  :status,
                  :authentication_url,
                  :authentication,
                  :authorization,
                  :merchant,
                  :holder,
                  :order,
                  :payment_method,
                  :return_url,
                  :authorize,
                  :do_capture,
                  :capture,
                  :free_field,
                  :bin,
                  :generate_token,
                  :avs,
                  :token,
                  :cancellation

    # Inicializa uma instância de Transaction informando os dados do estabelecimento,
    # portador do cartão, pedido, forma de pagamento, URL de retorno, método
    # de autorização e forma de captura.
    #
    # @param merchant [Merchant] Dados do estabelecimento comercial
    # @param holder [Holder] Portador do cartão
    # @param order [Order] Dados do pedido
    # @param payment_method [PaymentMethod] Forma de pagamento
    # @param return_url [String] URL de retorno
    # @param authorize [Number] Método de autorização
    # @param capture [Boolean] Se a transação deve ser capturada automaticamente
    def initialize(
      merchant,
      holder,
      order,
      payment_method,
      return_url,
      authorize,
      capture: true)

      @merchant = merchant
      @holder = holder
      @order = order
      @payment_method = payment_method
      @return_url = return_url
      @authorize = authorize
      @do_capture = capture
    end
  end
end

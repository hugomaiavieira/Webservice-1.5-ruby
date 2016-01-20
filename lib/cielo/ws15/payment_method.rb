module Cielo
  # Forma de pagamento da transação
  #
  # @attr [String] issuer Banco emissor do cartão
  # @attr [String] product Produto da Cielo utilizado
  # @attr [Number] installments Número de parcelas
  class PaymentMethod
    # Cartão Visa
    VISA = "visa"

    # Cartão Mastercard
    MASTERCARD = "mastercard"

    # Cartão Diners
    DINERS = "diners"

    # Cartão Discover
    DISCOVER = "discover"

    # Cartão ELO
    ELO = "elo"

    # Cartão Amex
    AMEX = "amex"

    # Cartão JCB
    JCB = "jcb"

    # Cartão Aura
    AURA = "aura"

    # Pagamento com cartão de crédito à vista
    CREDITO_A_VISTA = 1

    # Pagamento com cartão de crédito parcelado pela loja
    PARCELADO_LOJA = 2

    # Pagamento com cartão de crédito parcelado pela administradora
    PARCELADO_ADM = 3

    # Pagamento com cartão de débito
    DEBITO = "A"

    attr_accessor :issuer,
                  :product,
                  :installments

    # Inicializa uma instância de PaymentMethod informando o banco emissor do
    # cartão, produto Cielo e número de parcelas.
    #
    # @param issuer [String] Banco emissor do cartão
    # @param product [String] Produto Cielo que será utilizado
    # @param installments [Number] Número de parcelas; 1 para transação à vista
    def initialize(
      issuer,
      product = PaymentMethod::CREDITO_A_VISTA,
      installments = 1)

      @issuer = issuer
      @product = product
      @installments = installments
    end
  end
end

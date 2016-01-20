module Cielo
  class Order
    # Dados do estabelecimento comercial
    #
    # @attr [String] number Número do pedido na plataforma da loja
    # @attr [Number] total Valor do pedido em centavos
    # @attr [Number] Código ISO da moeda; 986 para Real
    # @attr [String] date_time Data e hora do pedido
    # @attr [String] description Descrição do pedido
    # @attr [String] language Idioma do pedido; PT para português
    # @attr [Number] shipping Valor do frete em centavos
    # @attr [String] soft_descriptor Nome de exibição na fatura do cartão
    attr_accessor :number,
                  :total,
                  :currency,
                  :date_time,
                  :description,
                  :language,
                  :shipping,
                  :soft_descriptor

    # Inicializa uma instância de Order informando o número do pedido, valor,
    # moeda e data de criação.
    #
    # @param number [String] Número do pedido na plataforma da loja
    # @param total [Number] Valor total do pedido em centavos
    # @param currency [Number] Código ISO que representa a moeda; 986 para Real
    # @param date_time [String] Data e hora do pedido na plataforma da loja
    def initialize(
      number = 0,
      total = 0,
      currency = 986,
      date_time = nil)

      if (date_time == nil)
        now = Time.now

        date_time = now.strftime("%Y-%m-%dT%H:%M:%S")
      end

      @number = number
      @total = total
      @currency = currency
      @language = "PT"
      @date_time = date_time
      @shipping = 0
    end
  end
end

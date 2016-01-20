module Cielo
  # Em casos de cancelamento, representa os dados do cancelamento
  #
  # @attr [String] code Código do cancelamento
  # @attr [String] message Mensagem do cancelamento
  # @attr [String] date_time Data e hora do cancelamento
  # @attr [Number] total Valor cancelado
  class Cancellation
    attr_accessor :code,
                  :message,
                  :date_time,
                  :total
  end
end

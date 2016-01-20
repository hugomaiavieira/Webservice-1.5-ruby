module Cielo
  # Em casos de captura, representa os dados da captura.
  #
  # @attr [String] code Código da captura
  # @attr [String] message Mensagem da captura
  # @attr [String] date_time Data e hora da captura
  # @attr [Number] total Valor capturado
  class Capture
    attr_accessor :code,
                  :message,
                  :date_time,
                  :total
  end
end

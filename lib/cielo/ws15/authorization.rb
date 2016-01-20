module Cielo
  # Dados da autorização
  #
  # @attr [String] code Código da autorização
  # @attr [String] message Mensagem da autorização
  # @attr [String] date_time Data e hora da autorização
  # @attr [Number] total Valor autorização
  # @attr [Number] lr Código LR da autorização
  # @attr [Number] arp Código ARP da autorização
  # @attr [Number] nsu Código NSU da autorização
  class Authorization
    attr_accessor :code,
                  :message,
                  :date_time,
                  :total,
                  :lr,
                  :arp,
                  :nsu
  end
end

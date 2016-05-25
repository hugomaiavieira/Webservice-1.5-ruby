require "cielo/ws15/lr_info"

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
                  :lr_info,
                  :arp,
                  :nsu

    # Os dois casos de sucesso são os seguintes:
    #
    # 00 - Transação nacional aprovada com sucesso
    # 11 - Transação internacional aprovada com sucesso
    def success?
      %w[00 11].include?(lr)
    end

    def failure?
      !success?
    end

    def lr=(lr_code)
      set_lr_info(lr_code)
      @lr = lr_code
    end

    private

    def set_lr_info(lr_code)
      @lr_info = LRInfo.new(lr_code)
    end
  end
end

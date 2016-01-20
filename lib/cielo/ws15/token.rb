module Cielo
  # Dados do token do cartão
  #
  # @attr [String] code Código do token para ser utilizado em outras transações
  # @attr [Number] status Status do token
  # @attr [String] Número do cartão truncado
  class Token
    attr_accessor :code,
                  :status,
                  :number
  end
end

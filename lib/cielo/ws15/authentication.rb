module Cielo
  # Em casos de autenticação, representa os dados da autenticação.
  #
  # @attr [String] code Código da autenticação
  # @attr [String] message Mensagem da autenticação
  # @attr [String] date_time Data e hora da autenticação
  # @attr [Number] total Valor autenticado
  # @attr [Number] eci Código ECI para a autenticação
  class Authentication
    attr_accessor :code,
                  :message,
                  :date_time,
                  :total,
                  :eci
  end
end

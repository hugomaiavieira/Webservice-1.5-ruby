module Cielo
  # Dados do portador
  #
  # @attr [String] token Token único do cartão
  # @attr [String] number Número do cartão
  # @attr [String] expiration Data de expiração do cartão
  # @attr [Number] indicator Indicador do código de segurança do cartão
  # @attr [String] cvv Código de segurança do cartão
  # @attr [String] name Nome do portador do cartão
  class Holder
    # Indica que o CVV não foi informado
    CVV_NOT_INFORMED = 0

    # Indica que o CVV foi informado
    CVV_INFORMED = 1

    # Indica que o CVV não estava legível
    CVV_UNREADABLE = 2

    # Indica que existe um CVV
    CVV_NONEXISTENT = 9

    attr_accessor :token,
                  :number,
                  :expiration,
                  :indicator,
                  :cvv,
                  :name

    # Inicializa uma nova instância de Holder, que representa o portador de um
    # cartão, definindo os dados do cartão ou apenas um token previamente gerado
    #
    # @param token_or_number [String] token ou o número do cartão do cliente
    # @param expiration_year [String] ano de expiração do cartão
    # @param expiration_month [String] mês de expiração do cartão
    # @param indicator [Number] indicador de visibilidade do código de segurança
    # @param cvv [String] Código de segurança do cartão
    def initialize(
      token_or_number,
      expiration_year = nil,
      expiration_month = nil,
      indicator = nil,
      cvv = Holder::CVV_NOT_INFORMED)

      if expiration_year.nil?
        @token = token_or_number
      else
        @number = token_or_number
        @expiration = "#{expiration_year}#{expiration_month.to_s.rjust(2, '0')}"
        @indicator = indicator
        @cvv = cvv
      end
    end
  end
end

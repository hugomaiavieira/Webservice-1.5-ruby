module Cielo
  # Dados do estabelecimento comercial
  #
  # @attr [String] affiliation_id Número de afiliação na Cielo
  # @attr [String] affiliation_key Chave de afiliação
  class Merchant
    attr_accessor :affiliation_id,
                  :affiliation_key


    # Inicializa uma nova instância de Merchat
    #
    # @param affiliation_id [String] Número de afiliação na Cielo
    # @param affiliation_key [String] Chave de afiliação
    def initialize(affiliation_id, affiliation_key)
      @affiliation_id = affiliation_id
      @affiliation_key = affiliation_key
    end
  end
end

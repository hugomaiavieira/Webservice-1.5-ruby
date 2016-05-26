require "cielo/ws15"

RSpec.describe Cielo::LRInfo do
  subject { described_class.new("14") }

  describe "#initialize" do
    it "should set the attributes based on the given code" do
      expect(subject.message).to eql("Cartão inválido")
      expect(subject.description).to eql("Digitação incorreta do número do cartão")
      expect(subject.action).to eql("Oriente o portador a verificar o número do cartão e digitar novamente")
      expect(subject.client_message).to eql("O número do cartão é inválido. Tente novamente informando o número do cartão corretamente.")
      expect(subject.retryable).to eql(false)
      expect(subject.card_error).to eql(true)
    end

    it "should set the default attributes when code is not found" do
      subject = described_class.new("52")

      expect(subject.message).to eql("Código 52 não identificado")
      expect(subject.description).to eql("Código 52 não identificado")
      expect(subject.action).to eql("Entre em contato com o Suporte Web Cielo eCommerce")
      expect(subject.client_message).to eql("Erro inesperado")
      expect(subject.retryable).to eql(false)
      expect(subject.card_error).to eql(false)
    end
  end

  describe "#card_error?" do
    it "should be true when card_error attribute is true" do
      subject.card_error = true
      expect(subject.card_error?).to eql(true)
    end

    it "should be false when card_error attribute is false" do
      subject.card_error = false
      expect(subject.card_error?).to eql(false)
    end
  end

  describe "#retryable?" do
    it "should be true when retryable attribute is true" do
      subject.retryable = true
      expect(subject.retryable?).to eql(true)
    end

    it "should be false when retryable attribute is false" do
      subject.retryable = false
      expect(subject.retryable?).to eql(false)
    end
  end
end
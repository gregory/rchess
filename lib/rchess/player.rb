require 'securerandom'

module Rchess
  class Player
    attr_reader :uuid
    attr_accessor :nick

    def initialize(nick)
      @uuid = SecureRandom.hex(10)
      @nick = nick
    end
  end
end

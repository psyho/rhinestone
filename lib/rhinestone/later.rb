module Rhinestone
  class Later
    def run(&block)
      EM.next_tick{ Fiber.new(&block).resume }
    end
  end
end

# frozen_string_literal: true

module SmartyStreets
  class Sleeper
    def sleep(seconds)
      Kernel.sleep(seconds)
    end
  end
end

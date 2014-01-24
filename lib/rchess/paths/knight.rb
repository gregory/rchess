module Rchess
  module Paths
    class Knight < Base
      def paths
        [l_paths].flatten(1)
      end

      private

      def l_paths
        [
          [{ x: 1, y: 2 }],
          [{ x: -1, y: 2 }],
          [{ x: 1, y: -2 }],
          [{ x: -1, y: -2 }]
        ]
      end
    end
  end
end

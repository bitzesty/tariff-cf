module Signonotron2
  class DbAdapter
    include Singleton

    SUPPORTED_DBS = %w(mysql postgresql).freeze

    SUPPORTED_DBS.each do |db_adapter|
      define_method "#{db_adapter}?" do
        adapter == db_adapter
      end
    end

    private

    def adapter
      @adapter ||= if ENV["SIGNONOTRON2_DB_ADAPTER"].blank?
        "mysql"
      else
        ENV["SIGNONOTRON2_DB_ADAPTER"]
      end
    end
  end
end

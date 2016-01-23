namespace :db do
  task fix_db_dump_pg: :environment do
    # DIRTY MONKEY PATCH FIX
    ActiveRecord::Tasks::PostgreSQLDatabaseTasks
    class ActiveRecord::Tasks::PostgreSQLDatabaseTasks
      def structure_dump(filename)
        return unless which("pg_dump")

        set_psql_env

        search_path = case ActiveRecord::Base.dump_schemas
        when :schema_search_path
          configuration['schema_search_path']
        when :all
          nil
        when String
          ActiveRecord::Base.dump_schemas
        end

        args = ['-s', '-x', '-O', '-f', filename]
        unless search_path.blank?
          args += search_path.split(',').map do |part|
            "--schema=#{part.strip}"
          end
        end
        args << configuration['database']
        run_cmd('pg_dump', args, 'dumping')
        File.open(filename, "a") { |f| f << "SET search_path TO #{connection.schema_search_path};\n\n" }
      end

      def which(cmd)
        exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
        ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
          exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable?(exe) && !File.directory?(exe)
          }
        end
        return nil
      end
    end
  end
end

Rake::Task["db:structure:dump"].enhance ["db:fix_db_dump_pg"]

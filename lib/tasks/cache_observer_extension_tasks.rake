namespace :radiant do
  namespace :extensions do
    namespace :cache_observer do
      
      desc "Runs the migration of the Cache Observer extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          CacheObserverExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          CacheObserverExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Cache Observer to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from CacheObserverExtension"
        Dir[CacheObserverExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(CacheObserverExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end

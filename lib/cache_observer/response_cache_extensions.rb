module CacheObserver::ResponseCacheExtensions
  def self.included(base)
    base.class_eval do
      
      def clear_with_observer
        clear_without_observer
        asd = system(CacheObserver::Config['script_path'])
        asd
      end
      
      alias_method_chain :clear, :observer
        
    end
  end  
end
# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

module CacheObserver
  if File.exists?(File.expand_path(File.dirname(__FILE__) + '/../../../config/cache.yml'))
    Config = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../../../config/cache.yml'))
  else
    Config = YAML.load_file(File.dirname(__FILE__) + "/config/cache.yml")
  end
end

class CacheObserverExtension < Radiant::Extension
  version "1.0"
  description "Run user-defined script after clearing the cache"
  url "http://github.com/astashov/radiant-cache-observer"

  def activate
    ResponseCache.send :include, CacheObserver::ResponseCacheExtensions
  end
  
  def deactivate
  end
  
end

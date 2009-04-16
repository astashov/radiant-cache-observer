require File.dirname(__FILE__) + '/../spec_helper'

describe ResponseCache do
  
  it "should run script after clearing the cache" do    
    dir = File.expand_path(File.dirname(__FILE__) + '/../')
    CacheObserver::Config['script_path'] = dir + '/test_script'
    output = dir + '/output'
    script = dir + '/test_script'
    # Clear output file
    File.open(output, 'w') {|f|  }
    File.open(script, 'w') {|f| f.print "#!/bin/bash\necho \"123\" > #{output}\n"}
    File.chmod(0755, script)
    @cache = ResponseCache.new
    @cache.clear
    File.read(dir + '/output').should == "123\n"
    File.delete(output, script)
  end

end
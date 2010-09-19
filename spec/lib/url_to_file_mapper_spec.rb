require 'spec_helper'
require 'url_to_file_mapper'

describe UrlToFileMapper do
  describe "#map" do
    it "should support custom index files" do
      UrlToFileMapper.map('/', :index => "custom.html").should == '/custom.html'
      UrlToFileMapper.map('/foo/', :index => "custom.html").should == '/foo/custom.html'
    end
  
    it "should map / to /index.html" do
      UrlToFileMapper.map('/').should == '/index.html'
    end
  
    it "should map /foo to /foo.html" do
      UrlToFileMapper.map('/foo').should == '/foo.html'
    end
  
    it "should map /foo/ to /foo/index.html" do
      UrlToFileMapper.map('/foo/').should == '/foo/index.html'
      UrlToFileMapper.map('/foo.ext/').should == '/foo.ext/index.html'
    end
  
    it "should not remap when asking for a specific extension" do
      UrlToFileMapper.map('/foo.ext').should == '/foo.ext'
    end
  end
  
  describe "#all_extension_variants_for" do
    before :all do
      @filename    = '/foo.html'
      @expectation = ['/foo.html', '/foo.markdown', '/foo.textile']
      @extensions  = ['.markdown', '.textile']
    end
    
    it "should not require a list of extensions" do
      UrlToFileMapper.all_extension_variants_for('/foo.html').should == ['/foo.html']
    end
    
    it "should always include the filename itself" do
      UrlToFileMapper.all_extension_variants_for('/foo.html', []).should == ['/foo.html']
    end
    
    it "should work with paths" do
      UrlToFileMapper.all_extension_variants_for('/foo/bar.html').should == ['/foo/bar.html']
    end
    
    it "should provide a list of variants" do
      UrlToFileMapper.all_extension_variants_for(@filename, @extensions).sort.should == @expectation.sort
    end
    
    it "should return the originally requested filename first" do
      UrlToFileMapper.all_extension_variants_for(@filename).first.should == @filename
      UrlToFileMapper.all_extension_variants_for(@filename, @extensions).first.should == @filename
    end
  end
end

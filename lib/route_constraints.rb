module RouteConstraints
  module SiteArea
    class IsSite
      def self.matches?(request); request.subdomain != "admin"; end
    end

    class IsNotSite
      def self.matches?(request); not ::RouteConstraints::SiteArea::IsSite.matches?(request); end
    end
    
    class PageRequest
      def self.matches?(request); File.extname(request.fullpath) == '.html'; end
    end
    
    class BlogRequest
      def self.matches?(request); request.fullpath =~ /^blog\//; end
    end
  end
end
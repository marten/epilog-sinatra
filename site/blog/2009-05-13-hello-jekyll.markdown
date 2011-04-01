--- 
wordpress_id: 6
layout: post
title: Hello mr. Jekyll
wordpress_url: http://journal.martenveldthuis.com/?p=6
---
<a rel="attachment wp-att-20" href="http://journal.martenveldthuis.com/2009/05/13/hello-jekyll/jekyll-and-hyde/"><img class="alignleft size-full wp-image-20" title="Dr. Jekyll and Mr. Hyde" src="http://journal.martenveldthuis.com/wp-content/uploads/2010/05/jekyll-and-hyde.jpg" alt="" width="170" height="235" /></a>This site is now running a — slightly modified — version of <a href="http://github.com/mojombo/jekyll">Jekyll</a>. The modifications I made are so that I can navigate by previous and next post within the category the post belongs to. I have a seperate category for photos and blogposts, and to stop previous/next links from intermingling I needed to add this feature. If you need it, you can find it in <a href="http://github.com/marten/jekyll">my fork</a>. The source for this site is <a href="http://github.com/marten/marten.veldthuis.com">here</a>, though the contents remain copyrighted. If you want to use my design, feel free to <a href="mailto:marten@veldthuis.com">send me an e-mail</a>, I’ll probably give you the go-ahead but I put the all rights reserved license on there to maintain control. And given that my photos end up there aswell, I thought this was just the easiest.
<h2><span style="font-weight: normal;"><span style="font-weight: normal;">Rake</span></span></h2>
Because of the photos, I needed thumbnails, and for that purpose I added a rakefile.
<div>
<pre><code>task :default =&gt; :publish

desc "Builds thumbnails for photos"
task :thumbs do
  files = Dir["photos/files/*.jpg"]

  FileUtils.mkdir_p("#{ROOT}/photos/files/thumbs-86")
  thumbs = Dir["photos/files/thumbs-86/*.jpg"].map {|th| File.basename(th) }
  files = files.reject {|file| thumbs.include?(File.basename(file)) }
  files.each do |file|
    dest = "#{ROOT}/photos/files/thumbs-86/#{File.basename(file)}"
    puts "Building #{dest}"
    `convert #{file} -thumbnail x172 -resize '172x&lt;' -resize 50% -gravity center -crop 86x86+0+0 +repage -format jpg -quality 91 #{dest}`
  end
end

desc "Run Jekyll"
task :build =&gt; :thumbs do
  puts `/Users/marten/code/ruby/jekyll/bin/jekyll`
end

desc "rsync everything to server"
task :publish =&gt; :build do
  puts `rsync -avz "#{ROOT}/_site/" marten@robinson.veldthuis.com:~/web/public/`
end
</code></pre>
<div><code>
</code></div>
</div>

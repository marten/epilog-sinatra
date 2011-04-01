--- 
wordpress_id: 262
layout: post
title: Golfing with Ruby
wordpress_url: http://martenveldthuis.com/?p=262
---
Yesterday we held the annual IWI Programming Contest at the university. For this contest, it's customary to have one problem which is longwindedly described, but extremely simple to write in code. This year, it basically came down to:

* Read a line containing an integer *n*
* Read *n* lines containing an integer *x*, and print `floor(x/5)`

We started [golfing](http://www.codegolf.com) this, and this is what I came up with:

    #!/usr/bin/ruby -n
    p $_.to_i/5 if $.>1

The tricky part here is ignoring the first line. It took me a little digging through the Ruby documentation to find that `$.` variable, which holds the current line number of the file (or `STDIN`) most recently read.

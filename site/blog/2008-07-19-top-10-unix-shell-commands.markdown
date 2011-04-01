--- 
wordpress_id: 252
layout: post
title: Top 10 Unix shell commands
wordpress_url: http://martenveldthuis.com/?p=252
---
<p>As seen <a href="http://kitenet.net/~joey/blog/entry/The_Top_Ten_Unix_Shell_Commands">elsewhere</a>, here's a list of the top ten commands I apparently use.</p>

<pre>
    $ history 1 | awk '{print $2}' | 
       awk 'BEGIN {FS="|"} {print $1}' | 
       sort | uniq -c | sort -r | head -10
    191 git
    191 cd
    161 sudo
    122 scp
    103 svn
     63 mv
     61 vim
     55 rm
     52 ssh
     52 cat
</pre>

Seems strange that something like <code>ls</code> isn't even on this list. Perhaps tabcompletion is the culprit here. But still… Ah well, it must be true, I used regexes!

count_words.sh
==============

Count words and make a page for statistics in [Zim](http://zim-wiki.org/)

See also: [Remove-line-breaks](https://github.com/jaap-karssenberg/zim-wiki/wiki/Remove-line-breaks-custom-tool) for another example of Custom Tools.

This shell script performs some stats useful for novel writer…

Compatible Linux and mac OS probably. (windows too, but with extra stuff to have a working bash command line)

How to setup:

- Download and put the script in your "/home/user/bin" directory or wherever you like 
- Make it executable. 
- Start a new Zim notebook dedicated for a novel.
- Setup a top page for the novel's chapters.
- Setup another page *stats* (or any funny name you used to) outside of the novel's chapters folder.

Mine looks like:

```
~/Notebooks/Novel$ tree
.
├── notebook.zim
├── Novel
│   ├── 01.chapter_1_a_dangerous_mission.txt
│   └── 02._That_can_happen_to_you.txt
├── Novel.txt
├── Tool_pages
│   └── stats.txt
└── Tool_pages.txt
```


The *Novel* folder will be used to group files together, each file is a chapter.

- Test the script from command line (terminal)

```bash
$ cd  /home/you/bin/or/funny_path/
$ ./count_words.sh /dev/stdout ~/Notebooks/Novel Novel
Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4

samedi 3 mai 2014, 16:13:44 (UTC+0200)

nombre de mots (estimé de page 400 mots / page)

'''
0  ./01.chapter_1_a_dangerous_mission.txt  0  p.
5  ./02._That_can_happen_to_you.txt        0  p.
5  total                                   0  p.
'''
```

*It works!*

Yes it's French output. Edit the code to set your own message.
I could have translated… But… No. ;)

Great continue with the custom tool now:

- Go into _Zim Tools_ --> _Custom Tools_, and add the script
	- Name: funny words stats
	- Description: Awesome tool to stat my progress about writing
	- Command: `/home/you/bin/or/funny_path/count_words.sh` %s %n *Novel*

"Novel" is the name of the "folder" top page holding the text file counted…
%s and %n are zim internal described in the form.

You can use "show in the toolbar" checkbox to have a button.

Be careful. Hitting the button will destroy the current page content replacing with the output above.

So use a dedicated stats page.

Have Fun! 

#!/bin/bash
# call from command line: ./count_words.sh /dev/stdout Notebookdir Novel_dir
# Zim custom tool: count_words.sh %s %n Novel_dir

# $dest the current zim's page will be overwritten
dest="$1"
nb_word_by_page=400
# This parameter set the Notebookdir/ subfolder containing the novel
# chapters. One page One chapter. As $3 you can set it in Custom Tools menu
novel_dir="$3"

# change to novel directory so we see only text file from this folder.
cd "$2/$novel_dir" || { echo "novel_dir not found" ; exit 1; }


# http://www.linuxjournal.com/content/floating-point-math-bash
FLOAT_SCALE=1
function float_eval()
{
    local stat=0
    local result=0.0
    if [[ $# -gt 0 ]]; then
        result=$(echo "scale=$FLOAT_SCALE; $*" | bc -q 2>/dev/null)
        stat=$?
        if [[ $stat -eq 0  &&  -z "$result" ]]; then stat=1; fi
    fi
    echo $result
    return $stat
}


# all the job is done in a function so it's simpler to redirect to any
# file or stdout for debuging. In Zim, the output go into a page.
do_stat()
{
	echo "Content-Type: text/x-zim-wiki"
	echo "Wiki-Format: zim 0.4"
	echo
	date 
	echo
	echo "nombre de mots (estimé de page $nb_word_by_page mots / page)"
	echo
	echo "'''" 

	# tmp out for computing data, piping to the for disable variable scope…

	out=/tmp/count_words_$$.tmp
	tot=0
	for f in $(find . -maxdepth 1 -name \*.txt -print | sort)
	do
		# skip zim header
		w=$(sed '1,7 d' $f | wc -w  )
		tot=$(( $tot + $w ))
		echo "$w $f $(float_eval $w / ${nb_word_by_page}.0) p." >> $out
	done 
	# compute sum of words for all chapters.
	echo "$tot total $(float_eval $tot / ${nb_word_by_page}.0) p." >> $out
	# column will text format the output.
	column -t $out
	rm $out
	echo "'''" 
}

do_stat > $dest


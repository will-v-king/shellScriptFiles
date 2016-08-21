#! /bin/bash -
# jTableBuilder.sh

# Output usage information
jTableBuilder(){
	OutputUsage(){
		echo "jTableBuilder works with UglifyJS2 .";
		echo "Usage: `basename $0` [options...]";
		echo "Options:";
		echo -e " -p, --path Set the path to search files\n ";
		echo -e " -l, --listFile (no argument follow) read source files direction from a list file.";
		echo -e " -s, --sourceFile source file name; when -l is on, it mean the list file name. ";
		echo -e " -d, --destinationFile the destination file name; when -d is on create option in the list file will be ignored.";
		echo -e " -h, --help Display this help and exit";
		echo "Example:";
		echo "bash jTableBuilder.sh -l -p /workspace/jquery/collection/jtable/dev/ -s jquery.jtable.build.uglst -d jquery.jtable-min.js";
		echo "now enjoy.";
		echo "author: iemaiwill<at>gmail.com";
		exit 1;
	}
	local path=".";
	local listFile="";
	local sourcePath="";
	local destinationPath="";
	local sourceFile="";
	local destinationFile="";
	local sourceFileDir="";
	local destinationFileDir="";
	local suffix="-debug.js";
	## STARTRegion LongOption
	# from /usr/share/doc/util-linux/examples/getopt-parse.bash
	# Note that we use `"$@"' to let each command-line parameter expand to a 
	# separate word. The quotes around `$@' are essential!
	# We need TEMP as the `eval set --' would nuke the return value of getopt.
	TEMP=`getopt -o p:le:s:n:d:x:h --long path:,sourcePath:,sourceFile:,destinationPath:,destinationFile:,suffix:,help \
		 -n 'example.bash' -- "$@"`

	if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
	# Note the quotes around `$TEMP': they are essential!
	eval set -- "$TEMP"

	while true ; do
		case "$1" in
			-h|--help) OutputUsage ;;
			-p|--path) path=$2 ; shift 2 ;;
			-l|--listFile) listFile="yes" ; shift 1 ;;
			-e|--sourcePath) sourcePath=$2 ; shift 2;;
			-s|--sourceFile) sourceFile=$2 ; shift 2 ;;
				## c has an optional argument. As we are in quoted mode,
				## an empty parameter will be generated if its optional
				## argument is not found.
				#case "$2" in
				#	"") echo "Option sourceHTMLFileType, no argument"; shift 2 ;;
				#	*)  echo "Option sourceHTMLFileType, argument \`$2'"; sourceHTMLFileType=$2 ; shift 2 ;;
				#esac ;;
			-n|--destinationPath) destinationPath=$2 ; shift 2 ;;
			-d|--destinationFile) destinationFile=$2 ; shift 2 ;;
			-x|--suffix) suffix=$2 ; shift 2 ;;
			--) shift ; break ;;
			*) echo "Internal error!" ; exit 1 ;;
		esac
	done
	if [ 0 -ne ${#1} ];
	then
		echo "Remaining arguments:";
		for arg do echo '--> '"\`$arg'" ; done
	fi
	## ENDRegion LongOption
	### BEGIN TIPS
	### /etc/bash_completion.d/
	##function _separateJSFromHTMLFile() {
	##    local cur prev opts
	##
	##    COMPREPLY=()
	##
	##    cur="${COMP_WORDS[COMP_CWORD]}"
	##    prev="${COMP_WORDS[COMP_CWORD-1]}"
	##    opts="-h --help -f --file -o --output"
	##
	##    if [[ ${cur} == -* ]] ; then
	##        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
	##        return 0
	##    fi
	##}
	##complete -F _separateJSFromHTMLFile separateJSFromHTMLFile
	### END TIPS
	preSetPath(){
		local zPath=${1};
		if [[ ${zPath} == "" ]];
		then
			zPath=${path};
		fi
		# return path , and make sure it's end with / .;
		echo ${zPath%\/}"/";
	}
	sourcePath="$(preSetPath ${sourcePath})";
	destinationPath="$(preSetPath ${destinationPath})";
	preSetFileName(){
		local zFileName=${1};
		# return filename , and make suer there's no path in the front of it.;
		echo ${zFileName##*/};
	}
	sourceFile="$(preSetFileName ${sourceFile})"
	destinationFile="$(preSetFileName ${destinationFile})"
	sourceFileDir=${sourcePath}${sourceFile};
	destinationFileDir=${destinationPath}${destinationFile};
	if [ -f ${sourceFileDir} ];
	then
		#cd ${sourcePath};
		# execute uglifyjs base on the list file.
		if [ ${listFile} ];
		then
			#sourceFileDir=$(cat ${sourceFileDir});
			#echo "1""$sourceFileDir";
			#echo $sourcePath;
			local sourceFileList=${sourceFileDir};
			mkdir -p `dirname ${destinationPath}`;
			if [ ! -d ${destinationFileDir} ];
			then
				echo "" > ${destinationFileDir};
			fi;
			#sourceFileDir="";
			#echo ${sourceFileList};
			while read LINE ;
			do
				if [[ ("$LINE" == create\ *) && (${destinationFile} == "") ]];
				then
					LINE="${LINE/create\ /}";
					echo ${destinationFileDir};
					echo $LINE
					destinationFileDir="${destinationFileDir}${LINE}";
					destinationFileDir="$(readlink -f ${destinationPath}${LINE})";
					echo ${destinationFileDir};
					echo -n "" > ${destinationFileDir};
				elif [[ $LINE == add\ * ]];
				then
					LINE=${LINE:4};
					if [[ $LINE == *\.js ]];
					then
						uglifyjs $(readlink -f ${sourcePath}${LINE}) -m -c --comments '/^[\ \/]*\*\ \@/' -p 8 >> ${destinationFileDir};
					else
						uglifyjs $(readlink -f ${sourcePath}${LINE}) -m -c --comments '/.*/' -p 8 >> ${destinationFileDir};
					fi;
					echo "" >> ${destinationFileDir};
				else
					echo -e $LINE" is a surprise";
				fi;
			done < <(cat ${sourceFileList}) ;
			echo ${destinationFileDir};
		else
				uglifyjs "${sourceFileDir}" -o ${destinationFileDir};
		fi;
	fi;
}
jTableBuilder "$@";

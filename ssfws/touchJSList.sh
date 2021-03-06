#! /bin/bash -
# minifyJS.sh
touchJSList(){
	local path=".";
	local sourcePath="";
	local destinationPath="";
	local sourceFile="";
	local destinationFile="";
	local sourceFileDir="";
	local destinationFileDir="";
	## STARTRegion LongOption
	# from /usr/share/doc/util-linux/examples/getopt-parse.bash
	# Note that we use `"$@"' to let each command-line parameter expand to a 
	# separate word. The quotes around `$@' are essential!
	# We need TEMP as the `eval set --' would nuke the return value of getopt.
	TEMP=`getopt -o p:s:d: --long path:,sourcePath:,sourceFile:,destinationPath:,destinationFile: \
		 -n 'example.bash' -- "$@"`

	if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
	# Note the quotes around `$TEMP': they are essential!
	eval set -- "$TEMP"

	while true ; do
		case "$1" in
			-p|--path) path=$2 ; shift 2 ;;
			--sourcePath) sourcePath=$2 ; shift 2;;
			-s|--sourceFile) sourceFile=$2 ; shift 2 ;;
				## c has an optional argument. As we are in quoted mode,
				## an empty parameter will be generated if its optional
				## argument is not found.
				#case "$2" in
				#	"") echo "Option sourceHTMLFileType, no argument"; shift 2 ;;
				#	*)  echo "Option sourceHTMLFileType, argument \`$2'"; sourceHTMLFileType=$2 ; shift 2 ;;
				#esac ;;
			--destinationPath) destinationPath=$2 ; shift 2 ;;
			-d|--destinationFile) destinationFile=$2 ; shift 2 ;;
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
	cd ${sourcePath};
	# READY TO FIND
	find ./*/ -type f -name "*.js" > "${destinationFileDir}"
}
touchJSList "$@";

#! /bin/bash -
# minifyJS.sh
# NOTICE the destination file must be end with min.js .;
minifyJS(){
	local path=".";
	local listFile="";
	local sourcePath="";
	local destinationPath="";
	local sourceFile="";
	local destinationFile="";
	local sourceFileDir="";
	local destinationFileDir="";
	local modifiedDate="200801310647";
	local suffix="-debug.js";
	## STARTRegion LongOption
	# from /usr/share/doc/util-linux/examples/getopt-parse.bash
	# Note that we use `"$@"' to let each command-line parameter expand to a 
	# separate word. The quotes around `$@' are essential!
	# We need TEMP as the `eval set --' would nuke the return value of getopt.
	TEMP=`getopt -o p:le:s:n:d:x:m: --long path:,sourcePath:,sourceFile:,destinationPath:,destinationFile:,modifiedDate:,suffix: \
		 -n 'example.bash' -- "$@"`

	if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
	# Note the quotes around `$TEMP': they are essential!
	eval set -- "$TEMP"

	while true ; do
		case "$1" in
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
			-m|--modifiedDate) modifiedDate=$2 ; shift 2 ;;
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
		cd ${sourcePath};
		# execute uglifyjs base on the list file.
		if [ ${listFile} ];
		then
			sourceFileDir=$(cat ${sourceFileDir} | while read LINE; do echo -n $LINE" "; done;);
			#uglifyjs -mt -ns -nc drop_debugger:false $(cat ${sourceFileDir} | while read LINE; do echo -n $LINE" "; done;) -o ${destinationFileDir} && uglifyjs -b beautify:false ${destinationFileDir} -o ${destinationPath}${destinationFile/%min.js/debug.js}
		fi;
		#uglifyjs -mt -ns -nc drop_debugger:false ${sourceFileDir} -o ${destinationFileDir} && uglifyjs -b beautify:false ${destinationFileDir} -o ${destinationPath}${destinationFile/%-min.js/${suffix}}
		# for node-uglifyjs
		# uglifyjs -ns -c --comments '^[\ \/]*\*\ \@' -b -o ${destinationPath}${destinationFile/%-min.js/-omg.js} ${sourceFileDir} && uglifyjs -mt -ns --source-map ${destinationPath}${destinationFile/%-min.js/-min.map} --source-map-url ${destinationPath}${destinationFile/%-min.js/-min.map} -c --comments '^[\ \/]*\*\ \@' -nc -o ${destinationFileDir} ${destinationPath}${destinationFile/%-min.js/-omg.js} && uglifyjs -mt -ns -c --comments '^[\ \/]*\*\ \@' -b -o ${destinationPath}${destinationFile/%-min.js/${suffix}} ${sourceFileDir}
		# uglifyjs "${sourceFileDir}" -ns -c --comments '^[\ \/]*\*\ \@' -b -o '${destinationPath}${destinationFile/%-min.js/-omg.js}' && uglifyjs "${destinationPath}${destinationFile/%-min.js/-omg.js}" -mt -ns --source-map ${destinationPath}${destinationFile/%-min.js/-min.map} --source-map-url ${destinationPath}${destinationFile/%-min.js/-min.map} -c --comments '^[\ \/]*\*\ \@' -nc -o ${destinationFileDir} && uglifyjs "${sourceFileDir}" -mt -ns -c --comments '^[\ \/]*\*\ \@' -b -o ${destinationPath}${destinationFile/%-min.js/${suffix}}
		uglifyjs ${sourceFileDir} -b -c --comments '/^[\ \/]*\*\ \@/' -p 8 > ${destinationPath}${destinationFile/%-min.js/-omg.js};
		uglifyjs ${destinationPath}${destinationFile/%-min.js/-omg.js} -mt -ns --source-map ${destinationPath}${destinationFile/%-min.js/-min.map} --source-map-url ${destinationPath}${destinationFile/%-min.js/-min.map}  -c --comments '/^[\ \/]*\*\ \@/' -p 8 -nc > ${destinationFileDir};
		uglifyjs ${sourceFileDir} -mt -ns -c --comments '/^[\ \/]*\*\ \@/' -p 8 -b > ${destinationPath}${destinationFile/%-min.js/${suffix}};
		touch -t "${modifiedDate}" ${destinationFileDir}
		touch -t "${modifiedDate}" ${destinationPath}${destinationFile/%-min.js/-omg.js}
		touch -t "${modifiedDate}" ${destinationPath}${destinationFile/%-min.js/${suffix}}
	fi;
}
minifyJS "$@";

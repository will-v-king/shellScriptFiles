#! /bin/bash -
#/home/wangz/bin/ssfws/minifyJS.sh -p /home/wangz/Workspace/eclipse/bcp/com.wisesoft.iimp.web/WebContent/static/js/extjs/application/ws/view/grid/ -e /home/wangz/Workspace/extjs-wise/application/ew/view/grid/ -s Panel.js.2014.07.01.in.short.js  -d Panel-min.js
minifyCMD(){
	local sourceBasePath="/home/wangz/Workspace/extjs-wise/";
	local sourcePath=${sourceBasePath}"application/ew/";
	local targetPath="/home/wangz/Workspace/eclipse/bcp/com.wisesoft.iimp.web/WebContent/static/js/extjs/application/ws/";
	local sourceList="uglist";
	#cat ${sourcePath}${sourceList} | while read LINE; do if [ $(($(date +%s)-$(date --utc --reference=${sourcePath}${LINE} +%s))) -lt 60 ]; then /home/wangz/bin/ssfws/minifyJS.sh -e `dirname ${sourcePath}${LINE}` -s ${LINE} -n `dirname ${targetPath}${LINE}` -d ${LINE/%.js/-min.js} -x ".js"; fi; done;
	## .src.js
	#TMP=view/grid/; cp $TMP"Panel.js" $TMP"Panel.tmp.js" && uglifyjs -nc join_vars:false $TMP"Panel.tmp.js" | uglifyjs -b -o $TMP"Panel.tmp.js" && sed -i -e 's/utils("getProperty")("\([a-zA-Z0-9_$]\{1,\}\)")/\1/g' $TMP"Panel.tmp.js" && cat $TMP"Panel.tmp.js" | grep getPropert
	local FOPath=${sourceBasePath}"FO/";
	local FSPath=${sourceBasePath}"FS/";
	local FMPath=${sourceBasePath}"FM/";
	#FOS
	echo "BEGIN FOS";
	cat ${FOPath}${sourceList} | while read LINE;
	do
		if [ $(($(date +%s)-$(date --utc --reference=${FOPath}${LINE} +%s))) -lt 60 ];
		then
			#/home/wangz/bin/ssfws/minifyJS.sh -e `dirname ${sourcePath}${LINE}` -s ${LINE} -n `dirname ${targetPath}${LINE}` -d ${LINE/%.js/-min.js} -x ".js";
			echo ${FSPath}${LINE};
			mkdir -p `dirname ${FSPath}${LINE}`;
			uglifyjs -nc -b beautify:true ${FOPath}${LINE} -o ${FSPath}${LINE};
		fi;
	done;
	echo "END FOS"
	#FSM
	cat ${FSPath}${sourceList} | while read LINE;
	do
		if [ $(($(date +%s)-$(date --utc --reference=${FSPath}${LINE} +%s))) -lt 60 ];
		then
			mkdir -p `dirname ${FMPath}${LINE}`;
			uglifyjs -nc -mt -ns drop_debugger:false ${FSPath}${LINE} -o ${FMPath}${LINE};
		fi;
	done;
	#ews
	targetPath="/home/wangz/Workspace/eclipse/bcp/com.wisesoft.iimp.web/WebContent/local/js/ws/";
	local ewPath="ew/";
	cat ${FMPath}${ewPath}${sourceList} | while read LINE;
	do
		if [ $(($(date +%s)-$(date --utc --reference=${FMPath}${ewPath}${LINE} +%s))) -lt 60 ];
		then
			mkdir -p `dirname ${targetPath}${LINE}`;
			uglifyjs -nc -b beautify:false ${FMPath}${ewPath}${LINE} -o ${targetPath}${LINE};
		fi;
	done;
}
minifyCMD "$@";

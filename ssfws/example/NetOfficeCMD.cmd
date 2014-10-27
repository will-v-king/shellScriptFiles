#! /bin/bash -
#/home/wangz/bin/ssfws/minifyJS.sh -p /home/wangz/Workspace/eclipse/bcp/com.wisesoft.iimp.web/WebContent/static/js/extjs/application/ws/view/grid/ -e /home/wangz/Workspace/extjs-wise/application/ew/view/grid/ -s Panel.js.2014.07.01.in.short.js  -d Panel-min.js
minifyCMD(){
	local PRG="$0"
	local PRGDIR=`dirname "$PRG"`
	#notify-send "${PRGDIR}""/""NetOfficeCMD";
	echo "NET:$PRGDIR" >> /home/lenovo/log.log
	local sourceBasePath=/media/sf_D_DRIVE/Programme_Files/scripts/js/;
	local sourcePath="${sourceBasePath}Common/";
	local targetPath="/media/sf_D_DRIVE/Workspace/WebApplication1/WebApplication1/Scripts/";
	local sourceList="uglist";
	#cat ${sourcePath}${sourceList} | while read LINE; do if [ $(($(date +%s)-$(date --utc --reference=${sourcePath}${LINE} +%s))) -lt 60 ]; then /home/wangz/bin/ssfws/minifyJS.sh -e `dirname ${sourcePath}${LINE}` -s ${LINE} -n `dirname ${targetPath}${LINE}` -d ${LINE/%.js/-min.js} -x ".js"; fi; done;
	## .src.js
	#TMP=view/grid/; cp $TMP"Panel.js" $TMP"Panel.tmp.js" && uglifyjs -nc join_vars:false $TMP"Panel.tmp.js" | uglifyjs -b -o $TMP"Panel.tmp.js" && sed -i -e 's/utils("getProperty")("\([a-zA-Z0-9_$]\{1,\}\)")/\1/g' $TMP"Panel.tmp.js" && cat $TMP"Panel.tmp.js" | grep getPropert
	local FOPath="${sourcePath}FO/";
	local FSPath="${sourcePath}FS/";
	local FMPath="${sourcePath}FM/";
	#FOS
	echo "BEGIN FOS";
	cat "${FOPath}${sourceList}" | while read LINE;
	do
		if [ $(($(date +%s)-$(date --utc --reference="${FOPath}${LINE}" +%s))) -lt 60 ];
		then
			#/home/wangz/bin/ssfws/minifyJS.sh -e `dirname ${sourcePath}${LINE}` -s ${LINE} -n `dirname ${targetPath}${LINE}` -d ${LINE/%.js/-min.js} -x ".js";
			echo "updateFS:${FSPath}${LINE}";
			mkdir -p "`dirname "${FSPath}${LINE}"`";
			#uglifyjs -nc -b beautify:true "${FOPath}"${LINE} -o "${FSPath}"${LINE};
			# for uglifyjs2
			#echo "uglifyjs \"${FOPath}${LINE}\" -c -b";
			uglifyjs "${FOPath}${LINE}" -o "${FSPath}${LINE}" -c -b quote-keys=true,indent-level=9,bracketize=true --comments;
			#uglifyjs "${FOPath}${LINE}" -c -b ;
			# for node-uglifyjs
			#uglifyjs -nc -ns -b -o "${FSPath}"${LINE} "${FOPath}"${LINE};
		fi;
	done;
	echo "END FOS"
	#FSM
	cat "${FSPath}${sourceList}" | while read LINE;
	do
		if [ $(($(date +%s)-$(date --utc --reference="${FSPath}${LINE}" +%s))) -lt 60 ];
		then
			mkdir -p "`dirname "${FMPath}${LINE}"`";
			echo "updateFM:${FMPath}${LINE}";
			#uglifyjs -nc -mt -ns drop_debugger:false "${FSPath}"${LINE} -o "${FMPath}"${LINE};
			# for uglifyjs2
			uglifyjs "${FSPath}${LINE}" -m -c drop_debugger=false,dead_code=true,join_vars=true,drop_console=true --source-map "${FMPath}${LINE}.map" --source-map-root "http://localhost/src" -p 5 -o "${FMPath}${LINE}" > "${FMPath}${LINE}";
			# for node-uglifyjs
			#uglifyjs -nc -mt -ns -o "${FMPath}"${LINE} "${FSPath}"${LINE};
		fi;
	done;
	# App
	targetPath="/media/sf_D_DRIVE/Workspace/2014-08-29_Net_Office/NEW/WebApplication1/WebApplication1/Scripts/";
	local ewPath="";
	cat "${FMPath}${ewPath}${sourceList}" | while read LINE;
	do
		if [ $(($(date +%s)-$(date --utc --reference="${FMPath}${ewPath}${LINE}" +%s))) -lt 60 ];
		then
			echo "updateFM:${FMPath}${ewPath}${LINE}";
			mkdir -p "`dirname "${targetPath}${LINE}"`";
			#uglifyjs -nc -b beautify:false "${FMPath}"${ewPath}${LINE} -o ${targetPath}${LINE};
			# for uglifyjs2
			uglifyjs "${FMPath}${ewPath}${LINE}" -m -c -b beautify=false -o "${targetPath}${LINE}";
			# for node-uglifyjs
			#uglifyjs -nc -b -o ${targetPath}${LINE} "${FMPath}"${ewPath}${LINE};
		fi;
	done;
}
minifyCMD "$@";

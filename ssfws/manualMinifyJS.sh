#! /bin/bash -
# manualMinifyJS
manualMinifyJS(){
	local EWPATH="/home/wangz/Workspace/extjs-wise/application/ew/";
	local PROPATH="/home/wangz/Workspace/eclipse/bcp/com.wisesoft.iimp.web/WebContent/static/js/extjs/application/ews/";
	local SHARED="shared";
	local PREDEFINE="pre-define";
	local GBCONFIG="gb-config";
	/home/wangz/bin/ssfws/minifyJS.sh --path ${EWPATH} -l --sourcePath ${EWPATH} --destinationPath ${EWPATH} -s uglist -d ews-min.js && cp ${EWPATH}ews-*.js ${PROPATH};
	#EXTJS PREDEFINE
	/home/wangz/bin/ssfws/minifyJS.sh --path ${EWPATH} --sourcePath ${EWPATH}../${SHARED}/ --destinationPath ${EWPATH}../${SHARED}/ -s ${PREDEFINE}.js -d ${PREDEFINE}-min.js && cp ${EWPATH}../${SHARED}/${PREDEFINE}-*.js ${PROPATH}../${SHARED}/;
	#EXTJS GLOBAL CONFIG FILE
	/home/wangz/bin/ssfws/minifyJS.sh --path ${EWPATH} --sourcePath ${EWPATH}../${SHARED}/ --destinationPath ${EWPATH}../${SHARED}/ -s ${GBCONFIG}.js -d ${GBCONFIG}-min.js && cp ${EWPATH}../${SHARED}/${GBCONFIG}-*.js ${PROPATH}../${SHARED}/;
	#xxd -ps  | xxd -ps -r.;
}
manualMinifyJS;

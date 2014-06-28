#! /bin/bash -
# manualMinifyJS
manualMinifyJS(){
	local EWPATH="/home/wangz/Workspace/extjs-wise/application/ew/";
	local PROPATH="/home/wangz/Workspace/eclipse/bcp/com.wisesoft.iimp.web/WebContent/static/js/extjs/application/ews/";
	/home/wangz/bin/ssfws/minifyJS.sh --path ${EWPATH} --sourcePath ${EWPATH} --destinationPath ${EWPATH} -s uglist -d ews-min.js && cp ${EWPATH}ews-*.js ${PROPATH};
	#xxd -ps  | xxd -ps -r.;
}
manualMinifyJS;

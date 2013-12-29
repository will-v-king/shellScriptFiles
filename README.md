shellScriptFiles
================
https://github.com/will-v-king/shellScriptFiles.git

##my shell script files (not all of them are written by me)

###DOSFileToUNIXFile		将DOS格式文件转换为UNIX格式。（系统中dos2unix程序功能应该更加强大，推荐了解。）

###collectKeywords		从文件中，分析出用到的Keywords。

		#文件名: collectKeywords
		#参数：
		# -p = [path];
		# -f = [fileTypes]/[from];
		# -r = [regularExpressionOfKeywords];
		# -t = [targetFileName]/[to];

###compdf		来自网络的脚本，用于合并多个PDF文件。

###downloadAndSave			用于根据清单下载，并根据清单重命名文件。

###eof		用于隐去输出。

###formatStrToReg		用于将字符串转换成正则匹配模式。

###freeMemory		检查内存剩余空间，并在内存空间不足时释放系统内存。

###getJSONObjectPropertyValue		用于读取JSON格式配置文件，并返回可读值。

###incrementalBackupUNIXFiles		自动增量备份UNIX格式文件（需要有清单）

		#文件名： ncrementalBackupUNIXFiles
		# -q quiet;
		# -f = [listFileName];
		# -t = [destFolderName]
		# 命令效果同 rsync --files-from="YDZQModifyFileList2013-2-1UNIX" ./ "update/"

###isVPNStarted

###readJSONConfigFile		用于读取JSON格式配置文件，并返回可读值。

###recordAudio		录音

###recordScreen		录屏，含录音。

###replaceStrInFolder		在指定文件夹中替换指定字符串。

###searchKeyWords		从文件夹中的特定类型文件中查找关键字词。

		#e.g.查找show="false" 和 show="true"的字段。:
		# searchKeyWords ../ "*" "show=\"\(false\)*\(true\)*\"" show.js

###separateJSFromHTMFile		从.htm文件中提取javascript代码（只有一段内嵌代码时），并保存到.js/目录下同名.js文件中，然后重命名.htm为.html文件，并清除内嵌javascript代码，增加js文件引用。


shellScriptFiles
================
https://github.com/will-v-king/shellScriptFiles.git

my shell script files (most of them are written by me)


incrementalBackupUNIXFiles		自动增量备份UNIX格式文件（需要有清单）

compdf		来自网络的脚本，用于合并多个PDF文件。

downloadAndSave			用于根据清单下载，并根据清单重命名文件。

DOSFileToUNIXFile		将DOS格式文件转换为UNIX格式。（系统中dos2unix程序功能应该更加强大，可以了解。）

searchKeyWords		从文件夹中的特定类型文件中查找关键字词。

		#searchKeyWords ../ "*" "show=\"\(false\)*\(true\)*\"" show.js    查找show="false" 和 show="true"的字段。

freeMemory		检查内存剩余空间，并在内存空间不足时释放系统内存。

separateJSFromHTMFile		从.htm文件中提取javascript代码（只有一段内嵌代码时），并保存到.js/目录下同名.js文件中，然后重命名.htm为.html文件，并清除内嵌javascript代码，增加js文件引用。

replaceStrInFolder		在指定文件夹中替换指定字符串。

collectKeywords		从文件中，分析出用到的Keywords。

		#文件名: collectKeywords -p = [path]; -f = [fileTypes]/[from]; -r = [regularExpressionOfKeywords];  -t = [targetFileName]/[to];

#! /bash/sh -
# used to solve the conflication between jQueryUI and EasyUI.
#cleanModuleInEasyUI.sh "draggable droppable resizable progressbar tooltip dialog accordion tabs menu spinner slider" "ez" "../../static/js/easyui/"
IFS=" ";
keywords=()
regularStr=""
prependStr=${2}
PRGDIR=$(dirname $0)
DIR=${3}
for f in ${1}
do
	echo ${f};
	keywords[${#keywords[*]}]=${f};
	regularStr=${regularStr}"\(${f}\)\|"
done
regularStr="\<\("${regularStr%\\\|}"\)\>"
echo "regularStr : "${regularStr};
#echo "keywords : " ${keywords[*]}; #Array
#sed -i -e "s/\([\(\.\)\(\ \)\(\;\)\(\"\)\(\'\)]\{1\}\)\(\(draggable\)\|\(droppable\)\|\(resizable\)\|\(progressbar\)\|\(tooltip\)\|\(dialog\)\|\(accordion\)\|\(tabs\)\|\(menu\)\|\(spinner\)\|\(slider\)\)/\1ez\2/g" `grep "\(\.\)\|\(\ \)\|\(;\)\(draggable\)\|\(droppable\)\|\(resizeable\)\|\(progressbar\)\|\(tooltip\)\|\(dialog\)\|\(accordion\)\|\(tabs\)\|\(menu\)\|\(spinner\)\|\(slider\)" -rl -A 0 -B 0 --exclude=*.svn* --exclude=*.swp --exclude-dir=.svn --exclude=*.backup "."`
if [ $(echo ${DIR})='' ];
then
	set DIR=${PRGDIR};
fi
echo '${DIR}:'${DIR}
IFS="
";
echo "sed -i -e \"s/${regularStr}/${prependStr}\1/g\" \`grep \"${regularStr}\" -rl -A 0 -B 0 --exclude=*.svn* --exclude=*.swp --exclude-dir=.svn --exclude=*.backup ${DIR}\`"
sed -i -e "s/${regularStr}/${prependStr}\1/g" `grep "${regularStr}" -rl -A 0 -B 0 --exclude=*.svn* --exclude=*.swp --exclude-dir=.svn --exclude=*.backup ${DIR}`
echo "Please Remember to Modify the name of the related files."

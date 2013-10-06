#! /bin/bash -
#  record screen within sound。
# recordScreen.sh ${fileName}
case "$2" in
	"") ffmpeg -f alsa -ac 2 -i default -f x11grab -s `xdpyinfo|grep 'dimensions:'|awk '{print $2}'` -r 20 -i :0.0 -sameq -strict experimental ${1};;
	*) ffmpeg -f alsa -ac 2 -i default -f x11grab -s "${2}" -r 20 -i :0.0"${3}" -sameq -strict experimental ${1};;
esac

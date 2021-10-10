#!/bin/bash

TARGET="latest"

if [ $# -ge 1 ]; then
        TARGET=$1
fi

URL="https://boin-cherry.oss-cn-shenzhen.aliyuncs.com/cherry_${TARGET}.tar.gz"
echo "Download cherry ${TARGET} from ${URL}"
cd /tmp
rm -rf cherry*.tar.gz
wget ${URL} -O cherry.tar.gz

if [ ! -f cherry.tar.gz ]; then
    echo "Download cherry ${URL} failed"
    exit 1
fi

filesize=`ls -l cherry.tar.gz | awk '{print $5}'`
if [ ${filesize} -eq 0 ];then
    exit 2
fi

tar -xvzf cherry.tar.gz
cd bin
./update.sh $2 $3
exit 0

#! /bin/bash

set -x
set -o errexit

cd "$(dirname "$0")"

ROOT_DIR=$(pwd)
BUILD=${ROOT_DIR}/build
GKO3_TRACKER=${ROOT_DIR}/output/gko3-tracker

BOOST_DIR=/usr/local/boost
PROTOBUF_DIR=/usr/local/protobuf
LIBEVENT_DIR=/usr/local/libevent
GFLAGS_DIR=/usr/local/gflags
GLOG_DIR=/usr/local/glog
THRIFT_DIR=/usr/local/thrift
HIREDIS=/usr/local/hiredis

for libdir in ${BOOST_DIR} ${PROTOBUF_DIR} ${LIBEVENT_DIR} ${THRIFT_DIR} ${GLOG_DIR} ${GFLAGS_DIR} ${HIREDIS}
do
    CMAKE_INCLUDE_PATH=${CMAKE_INCLUDE_PATH}:${libdir}/include
    CMAKE_LIBRARY_PATH=${CMAKE_LIBRARY_PATH}:${libdir}/lib
done

export CMAKE_INCLUDE_PATH=${CMAKE_INCLUDE_PATH}:${BOOST_DIR}/include/boost/tr1:/usr/local/include:/usr/include
export CMAKE_LIBRARY_PATH=${CMAKE_LIBRARY_PATH}:/usr/local/lib:/usr/lib64:/usr/lib

export PATH=$PROTOBUF_DIR/bin:$THRIFT_DIR/bin:$PATH

rm -fr ${GKO3_TRACKER}
mkdir -p ${GKO3_TRACKER} ${BUILD}
mkdir -p ${GKO3_TRACKER}/log

echo "Generate verion and timestamp ..."
echo $(date -d  today +%Y%m%d%H%M%S) > ${GKO3_TRACKER}/version


cd src && protoc --cpp_out=. *.proto && cd -
cd protocol && thrift --gen cpp -out . tracker.thrift && thrift --gen cpp -out . inner.thrift && thrift --gen cpp -out . announce.thrift && cd -
cd ${BUILD} && cmake .. -DCMAKE_INSTALL_PREFIX=${GKO3_TRACKER}/ && make && make install && cd - || exit $?

cd output && tar --owner=0 --group=0 --mode=-s --mode=go-w -czvf gko3-tracker.tgz gko3-tracker


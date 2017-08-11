SET(GKO3_TRACKER_SRC redis_conf.pb.cc
                     tracker_conf.pb.cc
                     AnnounceHandler.cpp
                     encode.cpp
                     hash_crc32.cpp
                     HttpServer.cpp
                     InfoHashGarbageCleaner.cpp
                     PeerHandler.cpp
                     PeerInfo.cpp
                     RedisManager.cpp
                     RemotePeersSyncronizer.cpp
                     StatusManager.cpp
                     TrackerErrorCategory.cpp
                     main.cpp)

INCLUDE(${PROJECT_SOURCE_DIR}/config.cmake)
ADD_EXECUTABLE(gko3-tracker ${GKO3_TRACKER_SRC})
TARGET_LINK_LIBRARIES(gko3-tracker gko3-protocol
                                   ${THRIFT_NB_LIB}
                                   ${THRIFT_LIB}
                                   minihttpd
                                   ${HIREDIS_LIB}
                                   ${GLOG_LIB}
                                   ${GFLAGS_LIB}
                                   ${PROTOBUF_LIB}
                                   ${LIBEVENT_LIB}
                                   ${BOOST_SYSTEM_LIB}
                                   ${BOOST_THREAD_LIB}
                                   pthread
                                   rt)

INSTALL(TARGETS gko3-tracker RUNTIME DESTINATION bin)

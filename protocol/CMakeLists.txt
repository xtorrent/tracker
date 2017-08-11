SET(GKO3_PROTOCOL_SRC tracker_constants.cpp
                      tracker_types.cpp
                      announce_constants.cpp
                      announce_types.cpp
                      Announce.cpp
                      inner_constants.cpp
                      inner_types.cpp)

SET(GKO3_PROTOCOL_HEADER tracker_constants.h
                         tracker_types.h
                         announce_constants.h
                         announce_types.h
                         Announce.h
                         inner_constants.h
                         inner_types.h)

ADD_LIBRARY(gko3-protocol STATIC ${GKO3_PROTOCOL_SRC})
INCLUDE(${PROJECT_SOURCE_DIR}/config.cmake)

INSTALL(TARGETS gko3-protocol ARCHIVE DESTINATION lib)
INSTALL(FILES ${GKO3_PROTOCOL_HEADER} DESTINATION include/bbts/tracker)
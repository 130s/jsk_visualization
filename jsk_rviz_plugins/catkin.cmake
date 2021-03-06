# these plugins should be uploaded to upstream repository
# https://github.com/ros-visualization/rviz/pull/634

# http://ros.org/doc/groovy/api/catkin/html/user_guide/supposed.html
cmake_minimum_required(VERSION 2.8.3)
project(jsk_rviz_plugins)
# Load catkin and all dependencies required for this package
# TODO: remove all from COMPONENTS that are not catkin packages.
find_package(catkin REQUIRED COMPONENTS rviz jsk_hark_msgs jsk_footstep_msgs jsk_pcl_ros
  message_generation std_msgs diagnostic_msgs)

add_message_files(FILES OverlayText.msg)
generate_messages(DEPENDENCIES std_msgs)

catkin_package(
    DEPENDS rviz
    CATKIN-DEPENDS jsk_hark_msgs jsk_footstep_msgs jsk_pcl_ros
    INCLUDE_DIRS # TODO include
    LIBRARIES # TODO
)


set(ROS_BUILD_TYPE Release)

include_directories(src ${Boost_INCLUDE_DIR} ${catkin_INCLUDE_DIRS})

# TODO: fill in what other packages will need to use this package
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need

find_package(Qt4 COMPONENTS QtCore QtGui REQUIRED)
include(${QT_USE_FILE})
add_definitions(-DQT_NO_KEYWORDS)

#find_package(wxWidgets REQUIRED)
#include(${wxWidgets_USE_FILE})
#include_directories( ${wxWidgets_INCLUDE_DIRS} )

#set(SOURCE_FILES src/ambient_sound_display.cpp src/ambient_sound_visual.cpp)
qt4_wrap_cpp(MOC_FILES
  src/ambient_sound_display_groovy.h
  src/select_point_cloud_publish_action.h
  src/footstep_display.h
  src/polygon_array_display.h
  src/normal_display.h
  src/overlay_text_display.h
  src/plotter_2d_display.h
  src/pie_chart_display.h
  src/diagnostics_display.h
  src/bounding_box_array_display.h
)

set(SOURCE_FILES
  src/ambient_sound_display_groovy.cpp
  src/ambient_sound_visual.cpp
  src/footstep_display.cpp
  src/select_point_cloud_publish_action.cpp
  src/polygon_array_display.cpp
  src/normal_display.cpp
  src/normal_visual.cpp
  src/overlay_text_display.cpp
  src/plotter_2d_display.cpp
  src/pie_chart_display.cpp
  src/diagnostics_display.cpp
  src/bounding_box_array_display.cpp
  ${MOC_FILES}
)

add_library(jsk_rviz_plugins ${SOURCE_FILES})
target_link_libraries(jsk_rviz_plugins ${QT_LIBRARIES})
add_dependencies(jsk_rviz_plugins jsk_hark_msgs_gencpp ${PROJECT_NAME}_gencpp)

install(FILES plugin_description.xml
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
install(TARGETS jsk_rviz_plugins
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION})

install(DIRECTORY scripts launch cfg
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  USE_SOURCE_PERMISSIONS)
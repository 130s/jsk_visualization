// -*- mode:c++ -*-
#ifndef NORMAL_VISUAL_H
#define NORMAL_VISUAL_H

#include <sensor_msgs/PointCloud2.h>

namespace Ogre
{
class Vector3;
class Quaternion;
}

namespace rviz
{
class Arrow;
}

namespace jsk_rviz_plugin
{

class NormalVisual
{
public:
  NormalVisual( Ogre::SceneManager* scene_manager, Ogre::SceneNode* parent_node );

  virtual ~NormalVisual();

  void setValues( float x, float y, float z, float normal_x, float normal_y, float  normal_z);

  void setFramePosition( const Ogre::Vector3& position );
  void setFrameOrientation( const Ogre::Quaternion& orientation );

  void setColor( float r, float g, float b, float a );

private:
  boost::shared_ptr<rviz::Arrow> acceleration_arrow_;

  Ogre::SceneNode* frame_node_;

  Ogre::SceneManager* scene_manager_;
};
}
#endif // NORMAL_VISUAL_H

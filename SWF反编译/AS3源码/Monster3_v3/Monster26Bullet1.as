package
{
   import base.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public dynamic class Monster26Bullet1 extends MovieClip
   {
       
      
      public function Monster26Bullet1()
      {
         super();
         addFrameScript(40,this.frame41);
      }
      
      function frame41() : *
      {
         BaseBullet(this.parent).destroy();
         stop();
      }
   }
}

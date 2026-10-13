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
   
   public dynamic class Monster18Bullet2 extends MovieClip
   {
       
      
      public function Monster18Bullet2()
      {
         super();
         addFrameScript(16,this.frame17,17,this.frame18);
      }
      
      function frame17() : *
      {
         BaseBullet(this.parent).destroy();
      }
      
      function frame18() : *
      {
         stop();
      }
   }
}

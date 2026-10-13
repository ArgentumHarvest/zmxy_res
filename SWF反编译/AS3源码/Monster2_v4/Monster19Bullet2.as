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
   
   public dynamic class Monster19Bullet2 extends MovieClip
   {
       
      
      public function Monster19Bullet2()
      {
         super();
         addFrameScript(11,this.frame12);
      }
      
      function frame12() : *
      {
         BaseBullet(this.parent).destroy();
         stop();
      }
   }
}

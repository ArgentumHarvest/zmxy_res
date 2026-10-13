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
   
   public dynamic class Monster19Bullet1 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function Monster19Bullet1()
      {
         super();
         addFrameScript(50,this.frame51);
      }
      
      function frame51() : *
      {
         BaseBullet(this.parent).destroy();
         stop();
      }
   }
}

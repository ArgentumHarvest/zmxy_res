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
   
   public dynamic class Monster18Bullet1 extends MovieClip
   {
       
      
      public function Monster18Bullet1()
      {
         super();
         addFrameScript(12,this.frame13,20,this.frame21,30,this.frame31,43,this.frame44);
      }
      
      function frame13() : *
      {
         BaseBullet(this.parent).newAttackId();
      }
      
      function frame21() : *
      {
         BaseBullet(this.parent).newAttackId();
      }
      
      function frame31() : *
      {
         BaseBullet(this.parent).newAttackId();
      }
      
      function frame44() : *
      {
         BaseBullet(this.parent).destroy();
         stop();
      }
   }
}

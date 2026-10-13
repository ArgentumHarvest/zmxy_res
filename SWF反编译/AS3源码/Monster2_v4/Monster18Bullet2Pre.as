package
{
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
   
   public dynamic class Monster18Bullet2Pre extends MovieClip
   {
       
      
      public function Monster18Bullet2Pre()
      {
         super();
         addFrameScript(24,this.frame25);
      }
      
      function frame25() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         stop();
      }
   }
}

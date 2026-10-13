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
   
   public dynamic class Monster19Bullet2Pre extends MovieClip
   {
       
      
      public function Monster19Bullet2Pre()
      {
         super();
         addFrameScript(23,this.frame24);
      }
      
      function frame24() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         stop();
      }
   }
}

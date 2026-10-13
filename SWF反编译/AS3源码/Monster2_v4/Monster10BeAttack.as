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
   
   public dynamic class Monster10BeAttack extends MovieClip
   {
       
      
      public function Monster10BeAttack()
      {
         super();
         addFrameScript(9,this.frame10);
      }
      
      function frame10() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         stop();
      }
   }
}

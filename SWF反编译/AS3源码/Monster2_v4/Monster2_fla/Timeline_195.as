package Monster2_fla
{
   import export.monster.*;
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
   
   public dynamic class Timeline_195 extends MovieClip
   {
       
      
      public function Timeline_195()
      {
         super();
         addFrameScript(23,this.frame24);
      }
      
      function frame24() : *
      {
         Monster11(this.parent).doHit3Effect();
         Monster11(this.parent).curAction = "wait";
         stop();
      }
   }
}

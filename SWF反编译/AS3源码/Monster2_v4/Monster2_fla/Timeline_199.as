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
   
   public dynamic class Timeline_199 extends MovieClip
   {
       
      
      public function Timeline_199()
      {
         super();
         addFrameScript(5,this.frame6);
      }
      
      function frame6() : *
      {
         Monster11(this.parent).curAction = "wait";
         Monster11(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

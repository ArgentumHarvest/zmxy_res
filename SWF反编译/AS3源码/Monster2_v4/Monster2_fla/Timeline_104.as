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
   
   public dynamic class Timeline_104 extends MovieClip
   {
       
      
      public function Timeline_104()
      {
         super();
         addFrameScript(29,this.frame30);
      }
      
      function frame30() : *
      {
         Monster9(this.parent).curAction = "wait";
         Monster9(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

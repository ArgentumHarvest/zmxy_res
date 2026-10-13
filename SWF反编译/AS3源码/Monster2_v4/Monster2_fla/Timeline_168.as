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
   
   public dynamic class Timeline_168 extends MovieClip
   {
       
      
      public function Timeline_168()
      {
         super();
         addFrameScript(48,this.frame49,49,this.frame50);
      }
      
      function frame49() : *
      {
         Monster18(this.parent).dohit2Pre();
      }
      
      function frame50() : *
      {
         Monster18(this.parent).curAction = "wait";
         Monster18(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

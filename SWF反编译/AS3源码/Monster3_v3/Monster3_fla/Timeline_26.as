package Monster3_fla
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
   
   public dynamic class Timeline_26 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function Timeline_26()
      {
         super();
         addFrameScript(100,this.frame101);
      }
      
      function frame101() : *
      {
         BaseMonster(this.parent).curAction = "wait";
         BaseMonster(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

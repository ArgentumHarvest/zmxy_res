package Monster2_fla
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
   
   public dynamic class hit1_151 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function hit1_151()
      {
         super();
         addFrameScript(12,this.frame13);
      }
      
      function frame13() : *
      {
         BaseMonster(this.parent).setStatic();
         BaseMonster(this.parent).curAction = "wait2";
         BaseMonster(this.parent).gotoAndStop("wait2");
         stop();
      }
   }
}

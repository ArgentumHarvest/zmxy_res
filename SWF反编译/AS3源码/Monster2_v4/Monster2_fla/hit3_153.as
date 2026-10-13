package Monster2_fla
{
   import base.*;
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
   
   public dynamic class hit3_153 extends MovieClip
   {
       
      
      public function hit3_153()
      {
         super();
         addFrameScript(4,this.frame5,17,this.frame18);
      }
      
      function frame5() : *
      {
         Monster19(this.parent).doHit3Pre();
      }
      
      function frame18() : *
      {
         BaseMonster(this.parent).setStatic();
         BaseMonster(this.parent).curAction = "wait1";
         BaseMonster(this.parent).gotoAndStop("wait1");
         stop();
      }
   }
}

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
   
   public dynamic class hit2_144 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function hit2_144()
      {
         super();
         addFrameScript(21,this.frame22,22,this.frame23);
      }
      
      function frame22() : *
      {
         Monster19(this.parent).doHit2();
      }
      
      function frame23() : *
      {
         BaseMonster(this.parent).setStatic();
         BaseMonster(this.parent).curAction = "wait2";
         BaseMonster(this.parent).gotoAndStop("wait2");
         stop();
      }
   }
}

package Monster3_fla
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
   
   public dynamic class Timeline_25 extends MovieClip
   {
       
      
      public function Timeline_25()
      {
         super();
         addFrameScript(10,this.frame11,20,this.frame21);
      }
      
      function frame11() : *
      {
         Monster26(this.parent).doHit1();
      }
      
      function frame21() : *
      {
         BaseMonster(this.parent).curAction = "wait";
         BaseMonster(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

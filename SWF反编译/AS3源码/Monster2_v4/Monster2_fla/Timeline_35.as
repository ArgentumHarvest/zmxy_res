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
   
   public dynamic class Timeline_35 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function Timeline_35()
      {
         super();
         addFrameScript(0,this.frame1,29,this.frame30,59,this.frame60);
      }
      
      function frame1() : *
      {
         BaseMonster(this.parent).setStatic();
      }
      
      function frame30() : *
      {
         BaseMonster(this.parent).speed.x = BaseMonster(this.parent).transform.matrix.a == 1 ? Number(-15) : Number(15);
      }
      
      function frame60() : *
      {
         BaseMonster(this.parent).setStatic();
         BaseMonster(this.parent).curAction = "wait";
         BaseMonster(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

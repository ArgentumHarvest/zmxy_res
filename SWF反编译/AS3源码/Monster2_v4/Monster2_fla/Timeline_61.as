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
   
   public dynamic class Timeline_61 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function Timeline_61()
      {
         super();
         addFrameScript(32,this.frame33,59,this.frame60);
      }
      
      function frame33() : *
      {
         BaseMonster(this.parent).newAttackId();
      }
      
      function frame60() : *
      {
         BaseMonster(this.parent).curAction = "wait";
         BaseMonster(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

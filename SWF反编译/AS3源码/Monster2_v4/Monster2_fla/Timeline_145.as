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
   
   public dynamic class Timeline_145 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function Timeline_145()
      {
         super();
         addFrameScript(11,this.frame12);
      }
      
      function frame12() : *
      {
         BaseMonster(this.parent).setStatic();
         BaseMonster(this.parent).curAction = "wait1";
         BaseMonster(this.parent).gotoAndStop("wait1");
         stop();
      }
   }
}

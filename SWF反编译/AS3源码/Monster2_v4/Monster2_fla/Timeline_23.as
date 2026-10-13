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
   
   public dynamic class Timeline_23 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function Timeline_23()
      {
         super();
         addFrameScript(44,this.frame45);
      }
      
      function frame45() : *
      {
         BaseMonster(this.parent).curAction = "wait";
      }
   }
}

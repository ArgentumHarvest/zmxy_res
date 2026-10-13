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
   
   public dynamic class Timeline_128 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function Timeline_128()
      {
         super();
         addFrameScript(9,this.frame10,19,this.frame20);
      }
      
      function frame10() : *
      {
         BaseMonster(this.parent).newAttackId();
      }
      
      function frame20() : *
      {
         BaseMonster(this.parent).curAction = "wait";
         stop();
      }
   }
}

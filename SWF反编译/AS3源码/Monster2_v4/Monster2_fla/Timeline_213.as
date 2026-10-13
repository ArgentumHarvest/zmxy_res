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
   
   public dynamic class Timeline_213 extends MovieClip
   {
       
      
      public function Timeline_213()
      {
         super();
         addFrameScript(8,this.frame9);
      }
      
      function frame9() : *
      {
         BaseMonster(this.parent.parent).newAttackId();
      }
   }
}

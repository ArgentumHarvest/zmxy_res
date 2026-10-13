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
   
   public dynamic class Timeline_41 extends MovieClip
   {
       
      
      public function Timeline_41()
      {
         super();
         addFrameScript(10,this.frame11,22,this.frame23,30,this.frame31);
      }
      
      function frame11() : *
      {
         BaseMonster(this.parent.parent).newAttackId();
      }
      
      function frame23() : *
      {
         BaseMonster(this.parent.parent).newAttackId();
      }
      
      function frame31() : *
      {
         stop();
      }
   }
}

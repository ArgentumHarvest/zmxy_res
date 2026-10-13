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
   
   public dynamic class Timeline_206 extends MovieClip
   {
       
      
      public function Timeline_206()
      {
         super();
         addFrameScript(24,this.frame25);
      }
      
      function frame25() : *
      {
         BaseMonster(this.parent).dropAura();
         BaseMonster(this.parent).destroy();
         stop();
      }
   }
}

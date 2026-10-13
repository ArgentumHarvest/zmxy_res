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
   
   public dynamic class Timeline_99 extends MovieClip
   {
       
      
      public var fire:MovieClip;
      
      public function Timeline_99()
      {
         super();
         addFrameScript(14,this.frame15,24,this.frame25);
      }
      
      function frame15() : *
      {
         Monster9(this.parent).fireHit();
      }
      
      function frame25() : *
      {
         if(!BaseMonster(this.parent).isFly)
         {
            BaseMonster(this.parent).curAction = "wait";
         }
         else
         {
            BaseMonster(this.parent).curAction = "fly";
         }
         stop();
      }
   }
}

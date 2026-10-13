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
   
   public dynamic class Timeline_92 extends MovieClip
   {
       
      
      public var fire:MovieClip;
      
      public var stick:MovieClip;
      
      public function Timeline_92()
      {
         super();
         addFrameScript(8,this.frame9,23,this.frame24);
      }
      
      function frame9() : *
      {
         Monster9(this.parent).fireHit();
      }
      
      function frame24() : *
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

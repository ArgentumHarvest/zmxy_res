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
   
   public dynamic class Timeline_108 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function Timeline_108()
      {
         super();
         addFrameScript(14,this.frame15);
      }
      
      function frame15() : *
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

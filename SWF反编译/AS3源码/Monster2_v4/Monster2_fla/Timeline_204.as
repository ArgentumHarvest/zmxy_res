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
   
   public dynamic class Timeline_204 extends MovieClip
   {
       
      
      public function Timeline_204()
      {
         super();
         addFrameScript(2,this.frame3,14,this.frame15);
      }
      
      function frame3() : *
      {
         if(this.parent is Monster14)
         {
            Monster14(this.parent).doHit1();
         }
      }
      
      function frame15() : *
      {
         if(this.parent is BaseMonster)
         {
            BaseMonster(this.parent).curAction = "wait";
            BaseMonster(this.parent).gotoAndStop("wait");
         }
         stop();
      }
   }
}

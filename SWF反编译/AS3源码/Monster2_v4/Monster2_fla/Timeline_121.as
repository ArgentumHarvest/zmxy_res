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
   
   public dynamic class Timeline_121 extends MovieClip
   {
       
      
      public function Timeline_121()
      {
         super();
         addFrameScript(2,this.frame3,14,this.frame15);
      }
      
      function frame3() : *
      {
         Monster13(this.parent).throwKnife();
      }
      
      function frame15() : *
      {
         BaseMonster(this.parent).curAction = "wait";
         stop();
      }
   }
}

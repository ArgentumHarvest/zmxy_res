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
   
   public dynamic class Timeline_52 extends MovieClip
   {
       
      
      public function Timeline_52()
      {
         super();
         addFrameScript(27,this.frame28,129,this.frame130);
      }
      
      function frame28() : *
      {
         if(!Monster23(this.parent).checkDohit5())
         {
            BaseMonster(this.parent).curAction = "wait";
            BaseMonster(this.parent).gotoAndStop("wait");
            stop();
         }
      }
      
      function frame130() : *
      {
         if(Monster23(this.parent).swapHero)
         {
            Monster23(this.parent).swapHero.reSetLostKeyboard();
            Monster23(this.parent).swapHero.visible = true;
         }
         BaseMonster(this.parent).curAction = "wait";
         BaseMonster(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

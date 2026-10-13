package Monster2_fla
{
   import export.hero.*;
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
   
   public dynamic class Timeline_56 extends MovieClip
   {
       
      
      public function Timeline_56()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      function frame1() : *
      {
         if(Monster23(this.parent.parent.parent).swapHero is Role1)
         {
            this.gotoAndStop(1);
         }
         else
         {
            this.gotoAndStop(2);
         }
      }
      
      function frame2() : *
      {
         if(Monster23(this.parent.parent.parent).swapHero is Role1)
         {
            this.gotoAndStop(1);
         }
         else
         {
            this.gotoAndStop(2);
         }
      }
   }
}

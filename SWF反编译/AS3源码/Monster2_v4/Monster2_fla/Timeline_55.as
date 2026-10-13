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
   
   public dynamic class Timeline_55 extends MovieClip
   {
       
      
      public function Timeline_55()
      {
         super();
         addFrameScript(4,this.frame5,20,this.frame21,36,this.frame37,53,this.frame54,70,this.frame71,87,this.frame88);
      }
      
      function frame5() : *
      {
         if(Monster23(this.parent.parent).swapHero)
         {
            Monster23(this.parent.parent).swapHero.reduceHp(Monster23(this.parent.parent).getRealPower("hit5"));
            Monster23(this.parent.parent).cureHp(Monster23(this.parent.parent).getRealPower("hit5"));
         }
      }
      
      function frame21() : *
      {
         if(Monster23(this.parent.parent).swapHero)
         {
            Monster23(this.parent.parent).swapHero.reduceHp(Monster23(this.parent.parent).getRealPower("hit5"));
            Monster23(this.parent.parent).cureHp(Monster23(this.parent.parent).getRealPower("hit5"));
         }
      }
      
      function frame37() : *
      {
         if(Monster23(this.parent.parent).swapHero)
         {
            Monster23(this.parent.parent).swapHero.reduceHp(Monster23(this.parent.parent).getRealPower("hit5"));
            Monster23(this.parent.parent).cureHp(Monster23(this.parent.parent).getRealPower("hit5"));
         }
      }
      
      function frame54() : *
      {
         if(Monster23(this.parent.parent).swapHero)
         {
            Monster23(this.parent.parent).swapHero.reduceHp(Monster23(this.parent.parent).getRealPower("hit5"));
            Monster23(this.parent.parent).cureHp(Monster23(this.parent.parent).getRealPower("hit5"));
         }
      }
      
      function frame71() : *
      {
         if(Monster23(this.parent.parent).swapHero)
         {
            Monster23(this.parent.parent).swapHero.reduceHp(Monster23(this.parent.parent).getRealPower("hit5"));
            Monster23(this.parent.parent).cureHp(Monster23(this.parent.parent).getRealPower("hit5"));
         }
      }
      
      function frame88() : *
      {
         stop();
      }
   }
}

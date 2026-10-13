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
   
   public dynamic class Timeline_97 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function Timeline_97()
      {
         super();
         addFrameScript(0,this.frame1,16,this.frame17,40,this.frame41);
      }
      
      function frame1() : *
      {
         Monster9(this.parent).setYourFather(41);
      }
      
      function frame17() : *
      {
         if(Monster9(this.parent).transform.matrix.a == 1)
         {
            Monster9(this.parent).speed.x = -25;
            Monster9(this.parent).isLeft = true;
         }
         else
         {
            Monster9(this.parent).speed.x = 25;
            Monster9(this.parent).isRight = true;
         }
         Monster9(this.parent).newAttackId();
      }
      
      function frame41() : *
      {
         if(!BaseMonster(this.parent).isFly)
         {
            BaseMonster(this.parent).curAction = "wait";
         }
         else
         {
            BaseMonster(this.parent).curAction = "fly";
         }
         BaseMonster(this.parent).setStatic();
         stop();
      }
   }
}

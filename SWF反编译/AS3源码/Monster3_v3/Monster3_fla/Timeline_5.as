package Monster3_fla
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
   
   public dynamic class Timeline_5 extends MovieClip
   {
       
      
      public function Timeline_5()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3,4,this.frame5,6,this.frame7,8,this.frame9,10,this.frame11,12,this.frame13,14,this.frame15,16,this.frame17,18,this.frame19,20,this.frame21,22,this.frame23,24,this.frame25);
      }
      
      function frame1() : *
      {
         BaseMonster(this.parent).visible = false;
      }
      
      function frame3() : *
      {
         BaseMonster(this.parent).visible = true;
      }
      
      function frame5() : *
      {
         BaseMonster(this.parent).visible = false;
      }
      
      function frame7() : *
      {
         BaseMonster(this.parent).visible = true;
      }
      
      function frame9() : *
      {
         BaseMonster(this.parent).visible = false;
      }
      
      function frame11() : *
      {
         BaseMonster(this.parent).visible = true;
      }
      
      function frame13() : *
      {
         BaseMonster(this.parent).visible = false;
      }
      
      function frame15() : *
      {
         BaseMonster(this.parent).visible = true;
      }
      
      function frame17() : *
      {
         BaseMonster(this.parent).visible = false;
      }
      
      function frame19() : *
      {
         BaseMonster(this.parent).visible = true;
      }
      
      function frame21() : *
      {
         BaseMonster(this.parent).visible = false;
      }
      
      function frame23() : *
      {
         BaseMonster(this.parent).visible = true;
      }
      
      function frame25() : *
      {
         BaseMonster(this.parent).destroy();
         stop();
      }
   }
}

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
   
   public dynamic class hit1_167 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function hit1_167()
      {
         super();
         addFrameScript(0,this.frame1,33,this.frame34,36,this.frame37,39,this.frame40,42,this.frame43,45,this.frame46,47,this.frame48,48,this.frame49);
      }
      
      function frame1() : *
      {
      }
      
      function frame34() : *
      {
         BaseMonster(this.parent).speed.x = BaseMonster(this.parent).transform.matrix.a == 1 ? Number(-20) : Number(20);
      }
      
      function frame37() : *
      {
         BaseMonster(this.parent).speed.x = BaseMonster(this.parent).transform.matrix.a == 1 ? Number(-20) : Number(20);
      }
      
      function frame40() : *
      {
         BaseMonster(this.parent).speed.x = BaseMonster(this.parent).transform.matrix.a == 1 ? Number(-20) : Number(20);
      }
      
      function frame43() : *
      {
         BaseMonster(this.parent).speed.x = BaseMonster(this.parent).transform.matrix.a == 1 ? Number(-20) : Number(20);
      }
      
      function frame46() : *
      {
         BaseMonster(this.parent).speed.x = BaseMonster(this.parent).transform.matrix.a == 1 ? Number(-20) : Number(20);
      }
      
      function frame48() : *
      {
         BaseMonster(this.parent).setStatic();
         BaseMonster(this.parent).curAction = "wait";
         BaseMonster(this.parent).gotoAndStop("wait");
      }
      
      function frame49() : *
      {
         stop();
      }
   }
}

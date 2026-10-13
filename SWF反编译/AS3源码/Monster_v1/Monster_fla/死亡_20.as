package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 死亡_20 extends MovieClip
   {
       
      
      public var mc:MovieClip;
      
      public function 死亡_20()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3,4,this.frame5,6,this.frame7,8,this.frame9,10,this.frame11,12,this.frame13,14,this.frame15,16,this.frame17,18,this.frame19,20,this.frame21,22,this.frame23,24,this.frame25);
      }
      
      function frame1() : *
      {
         BaseMonster(this.parent).setStatic();
      }
      
      function frame3() : *
      {
         BaseMonster(this.parent).visible = false;
      }
      
      function frame5() : *
      {
         BaseMonster(this.parent).visible = true;
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
         BaseMonster(this.parent).visible = false;
         this.mc = new BossDead();
         this.mc.x = BaseMonster(this.parent).x;
         this.mc.y = BaseMonster(this.parent).y;
         BaseMonster(this.parent).parent.addChild(this.mc);
         stop();
      }
   }
}

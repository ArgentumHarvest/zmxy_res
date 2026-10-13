package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 受伤_16 extends MovieClip
   {
       
      
      public function 受伤_16()
      {
         super();
         addFrameScript(10,this.frame11);
      }
      
      function frame11() : *
      {
         BaseMonster(this.parent).setStatic();
         BaseMonster(this.parent).curAction = "walk";
         BaseMonster(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

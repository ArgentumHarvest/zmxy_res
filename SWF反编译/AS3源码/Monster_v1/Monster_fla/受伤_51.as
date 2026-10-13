package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 受伤_51 extends MovieClip
   {
       
      
      public function 受伤_51()
      {
         super();
         addFrameScript(12,this.frame13);
      }
      
      function frame13() : *
      {
         if(!BaseMonster(this.parent).isDead())
         {
            BaseMonster(this.parent).curAction = "wait";
            BaseMonster(this.parent).gotoAndStop("wait");
         }
         stop();
      }
   }
}

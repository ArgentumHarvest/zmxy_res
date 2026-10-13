package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 受伤_64 extends MovieClip
   {
       
      
      public function 受伤_64()
      {
         super();
         addFrameScript(12,this.frame13);
      }
      
      function frame13() : *
      {
         BaseMonster(this.parent).curAction = "wait";
         BaseMonster(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

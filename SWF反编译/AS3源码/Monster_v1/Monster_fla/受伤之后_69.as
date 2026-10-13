package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 受伤之后_69 extends MovieClip
   {
       
      
      public function 受伤之后_69()
      {
         super();
         addFrameScript(9,this.frame10);
      }
      
      function frame10() : *
      {
         BaseMonster(this.parent).curAction = "walk";
         stop();
      }
   }
}

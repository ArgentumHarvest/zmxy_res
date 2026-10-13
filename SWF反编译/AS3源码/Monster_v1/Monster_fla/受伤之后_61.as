package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 受伤之后_61 extends MovieClip
   {
       
      
      public function 受伤之后_61()
      {
         super();
         addFrameScript(7,this.frame8);
      }
      
      function frame8() : *
      {
         BaseMonster(this.parent).curAction = "walk";
         stop();
      }
   }
}

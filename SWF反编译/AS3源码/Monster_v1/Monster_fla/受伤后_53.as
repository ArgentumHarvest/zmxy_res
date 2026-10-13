package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 受伤后_53 extends MovieClip
   {
       
      
      public function 受伤后_53()
      {
         super();
         addFrameScript(6,this.frame7);
      }
      
      function frame7() : *
      {
         BaseMonster(this.parent).curAction = "walk";
         stop();
      }
   }
}

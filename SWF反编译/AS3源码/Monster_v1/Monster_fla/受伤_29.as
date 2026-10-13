package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 受伤_29 extends MovieClip
   {
       
      
      public function 受伤_29()
      {
         super();
         addFrameScript(13,this.frame14);
      }
      
      function frame14() : *
      {
         if(BaseMonster(this.parent))
         {
            BaseMonster(this.parent).setStatic();
            BaseMonster(this.parent).curAction = "walk";
            BaseMonster(this.parent).gotoAndStop("wait");
            stop();
         }
      }
   }
}

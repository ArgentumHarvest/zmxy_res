package Monster_fla
{
   import base.BaseMonster;
   import export.monster.Monster4;
   import flash.display.MovieClip;
   
   public dynamic class 元件14ssssss_8 extends MovieClip
   {
       
      
      public function 元件14ssssss_8()
      {
         super();
         addFrameScript(3,this.frame4,52,this.frame53);
      }
      
      function frame4() : *
      {
         Monster4(this.parent).doHit3();
      }
      
      function frame53() : *
      {
         if(BaseMonster(this.parent))
         {
            BaseMonster(this.parent).curAction = "wait";
            BaseMonster(this.parent).gotoAndStop("wait");
            stop();
         }
      }
   }
}

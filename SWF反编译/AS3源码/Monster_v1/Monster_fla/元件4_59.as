package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件4_59 extends MovieClip
   {
       
      
      public function 元件4_59()
      {
         super();
         addFrameScript(14,this.frame15);
      }
      
      function frame15() : *
      {
         if(BaseMonster(this.parent).standInObj)
         {
            BaseMonster(this.parent).dropAura();
            BaseMonster(this.parent).destroy();
            stop();
         }
         else
         {
            this.gotoAndPlay(9);
         }
      }
   }
}

package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件6_52 extends MovieClip
   {
       
      
      public function 元件6_52()
      {
         super();
         addFrameScript(19,this.frame20);
      }
      
      function frame20() : *
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

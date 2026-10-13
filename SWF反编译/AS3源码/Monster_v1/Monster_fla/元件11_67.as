package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件11_67 extends MovieClip
   {
       
      
      public function 元件11_67()
      {
         super();
         addFrameScript(21,this.frame22);
      }
      
      function frame22() : *
      {
         trace(BaseMonster(this.parent).standInObj);
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

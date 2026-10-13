package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件12_26 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function 元件12_26()
      {
         super();
         addFrameScript(82,this.frame83);
      }
      
      function frame83() : *
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

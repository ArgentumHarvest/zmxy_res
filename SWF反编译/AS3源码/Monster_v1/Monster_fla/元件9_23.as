package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件9_23 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function 元件9_23()
      {
         super();
         addFrameScript(22,this.frame23);
      }
      
      function frame23() : *
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

package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件3sssss_17 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function 元件3sssss_17()
      {
         super();
         addFrameScript(16,this.frame17);
      }
      
      function frame17() : *
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

package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件23_39 extends MovieClip
   {
       
      
      public function 元件23_39()
      {
         super();
         addFrameScript(12,this.frame13);
      }
      
      function frame13() : *
      {
         BaseMonster(this.parent).setStatic();
         BaseMonster(this.parent).speed.y = 0;
         BaseMonster(this.parent).curAction = "wait";
         BaseMonster(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

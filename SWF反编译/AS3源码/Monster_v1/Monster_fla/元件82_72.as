package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件82_72 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function 元件82_72()
      {
         super();
         addFrameScript(12,this.frame13);
      }
      
      function frame13() : *
      {
         BaseMonster(this.parent).curAction = "wait";
         BaseMonster(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

package Monster_fla
{
   import export.monster.Monster1;
   import flash.display.MovieClip;
   
   public dynamic class 元件3_58 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function 元件3_58()
      {
         super();
         addFrameScript(23,this.frame24);
      }
      
      function frame24() : *
      {
         Monster1(this.parent).curAction = "wait";
         Monster1(this.parent).gotoAndStop("wait");
         stop();
      }
   }
}

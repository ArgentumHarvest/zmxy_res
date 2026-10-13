package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件20_35 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function 元件20_35()
      {
         super();
         addFrameScript(19,this.frame20);
      }
      
      function frame20() : *
      {
         BaseMonster(this.parent).curAction = "wait";
      }
   }
}

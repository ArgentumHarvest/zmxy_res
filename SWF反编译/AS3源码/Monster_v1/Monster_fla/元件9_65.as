package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件9_65 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function 元件9_65()
      {
         super();
         addFrameScript(11,this.frame12);
      }
      
      function frame12() : *
      {
         BaseMonster(this.parent).curAction = "wait";
      }
   }
}

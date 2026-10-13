package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件4_50 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function 元件4_50()
      {
         super();
         addFrameScript(16,this.frame17);
      }
      
      function frame17() : *
      {
         BaseMonster(this.parent).curAction = "walk";
      }
   }
}

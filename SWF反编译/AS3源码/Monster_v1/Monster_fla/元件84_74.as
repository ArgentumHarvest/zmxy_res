package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件84_74 extends MovieClip
   {
       
      
      public function 元件84_74()
      {
         super();
         addFrameScript(23,this.frame24);
      }
      
      function frame24() : *
      {
         BaseMonster(this.parent).dropAura();
         BaseMonster(this.parent).destroy();
         stop();
      }
   }
}

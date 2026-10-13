package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件32_46 extends MovieClip
   {
       
      
      public function 元件32_46()
      {
         super();
         addFrameScript(21,this.frame22);
      }
      
      function frame22() : *
      {
         BaseMonster(this.parent).dropAura();
         BaseMonster(this.parent).destroy();
         stop();
      }
   }
}

package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 蝙蝠死_40 extends MovieClip
   {
       
      
      public function 蝙蝠死_40()
      {
         super();
         addFrameScript(25,this.frame26);
      }
      
      function frame26() : *
      {
         BaseMonster(this.parent).dropAura();
         BaseMonster(this.parent).destroy();
         stop();
      }
   }
}

package Monster_fla
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public dynamic class 元件14_28 extends MovieClip
   {
       
      
      public function 元件14_28()
      {
         super();
         addFrameScript(14,this.frame15,18,this.frame19,23,this.frame24,29,this.frame30,35,this.frame36,44,this.frame45);
      }
      
      function frame15() : *
      {
         BaseMonster(this.parent.parent).newAttackId();
      }
      
      function frame19() : *
      {
         BaseMonster(this.parent.parent).newAttackId();
      }
      
      function frame24() : *
      {
         BaseMonster(this.parent.parent).newAttackId();
      }
      
      function frame30() : *
      {
         BaseMonster(this.parent.parent).newAttackId();
      }
      
      function frame36() : *
      {
         BaseMonster(this.parent.parent).newAttackId();
      }
      
      function frame45() : *
      {
         stop();
      }
   }
}

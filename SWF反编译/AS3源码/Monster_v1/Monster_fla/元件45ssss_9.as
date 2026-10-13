package Monster_fla
{
   import base.BaseMonster;
   import config.Config;
   import flash.display.MovieClip;
   
   public dynamic class 元件45ssss_9 extends MovieClip
   {
       
      
      public var stick:MovieClip;
      
      public function 元件45ssss_9()
      {
         super();
         addFrameScript(4,this.frame5,7,this.frame8,10,this.frame11,12,this.frame13,15,this.frame16,19,this.frame20,21,this.frame22,24,this.frame25,29,this.frame30,31,this.frame32,34,this.frame35,40,this.frame41,45,this.frame46,51,this.frame52,57,this.frame58,64,this.frame65,75,this.frame76);
      }
      
      function frame5() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(5);
      }
      
      function frame8() : *
      {
         Config.getInstance().vControllor.shake(5);
      }
      
      function frame11() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(5);
      }
      
      function frame13() : *
      {
         Config.getInstance().vControllor.shake(5);
      }
      
      function frame16() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(10);
      }
      
      function frame20() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(10);
      }
      
      function frame22() : *
      {
         Config.getInstance().vControllor.shake(10);
      }
      
      function frame25() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(10);
      }
      
      function frame30() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(10);
      }
      
      function frame32() : *
      {
         Config.getInstance().vControllor.shake(10);
      }
      
      function frame35() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(15);
      }
      
      function frame41() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(15);
      }
      
      function frame46() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(15);
      }
      
      function frame52() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(15);
      }
      
      function frame58() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(15);
      }
      
      function frame65() : *
      {
         BaseMonster(this.parent).newAttackId();
         Config.getInstance().vControllor.shake(15);
      }
      
      function frame76() : *
      {
         if(BaseMonster(this.parent))
         {
            BaseMonster(this.parent).curAction = "wait";
            BaseMonster(this.parent).gotoAndStop("wait");
            stop();
         }
      }
   }
}

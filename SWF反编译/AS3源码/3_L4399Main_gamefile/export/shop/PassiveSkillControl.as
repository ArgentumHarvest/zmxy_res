package export.shop
{
   import flash.display.Sprite;
   import flash.events.Event;
   import user.User;
   
   public class PassiveSkillControl extends Sprite
   {
       
      
      private var player:User;
      
      public var pskill1:PassiveSkill;
      
      public var pskill2:PassiveSkill;
      
      public var pskill3:PassiveSkill;
      
      public var pskill4:PassiveSkill;
      
      public var pskill5:PassiveSkill;
      
      public function PassiveSkillControl(_user:User)
      {
         super();
         this.player = _user;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var i:* = 0;
         for(i = uint(0); i < 5; )
         {
            this["pskill" + (i + 1)].setRole(this.player);
            i++;
         }
      }
      
      private function removed(e:Event) : void
      {
      }
   }
}

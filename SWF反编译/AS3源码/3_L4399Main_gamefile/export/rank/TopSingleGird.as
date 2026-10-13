package export.rank
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class TopSingleGird extends Sprite
   {
       
      
      public var valuetxt:TextField;
      
      public var nametxt:TextField;
      
      public var toptxt:TextField;
      
      public var zgtxt:TextField;
      
      public var gxtxt:TextField;
      
      private var rankUser:RankUsers;
      
      private var handmc:Sprite;
      
      public function TopSingleGird(_rankUser:RankUsers)
      {
         handmc = new Sprite();
         super();
         this.rankUser = _rankUser;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.setTxt();
         this.handmc.graphics.beginFill(16711680,0);
         this.handmc.graphics.drawRect(-206,-15.5,424,31);
         this.handmc.graphics.endFill();
         this.handmc.buttonMode = true;
         this.addChild(this.handmc);
      }
      
      private function removed(e:Event) : void
      {
         if(this.handmc && this.contains(this.handmc))
         {
            this.removeChild(this.handmc);
            this.handmc = null;
         }
      }
      
      public function getRankUsers() : RankUsers
      {
         if(this.rankUser)
         {
            return this.rankUser;
         }
         return null;
      }
      
      private function setTxt() : void
      {
         if(this.rankUser)
         {
            this.valuetxt.text = this.rankUser.getScore() - this.rankUser.getGongXun() + "";
            this.nametxt.text = this.rankUser.getUserName() + "";
            this.toptxt.text = this.rankUser.getRank() + "";
            this.zgtxt.text = this.rankUser.getScore() + "";
            this.gxtxt.text = this.rankUser.getGongXun() + "";
         }
         else
         {
            this.valuetxt.text = "";
            this.nametxt.text = "";
            this.toptxt.text = "";
            this.zgtxt.text = "";
            this.gxtxt.text = "";
         }
      }
   }
}

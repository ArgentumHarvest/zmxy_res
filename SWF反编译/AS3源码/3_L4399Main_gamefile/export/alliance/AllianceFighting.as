package export.alliance
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.SingleSavedBuff;
   
   public class AllianceFighting extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var showtxt:TextField;
      
      private var gc:Config;
      
      private var newshowtxt:TextField;
      
      public function AllianceFighting()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         xbtn.addEventListener("click",xClick);
         gbtn.addEventListener("click",gClick);
         if(this.showtxt && this.contains(this.showtxt))
         {
            this.removeChild(this.showtxt);
         }
         this.showTxt();
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         xbtn.removeEventListener("click",xClick);
         gbtn.removeEventListener("click",gClick);
      }
      
      private function showTxt() : void
      {
         var showStr:String = "联盟等级： " + gc.honorData.allianceLevel + " 级，联盟的等级越高，效果越强。<br>攻击力增加： " + gc.honorData.allianceLevel * gc.dataObject.fifty + " 点";
         this.newshowtxt = new TextField();
         this.newshowtxt.selectable = false;
         this.newshowtxt.x = 346;
         this.newshowtxt.y = 286.25;
         this.newshowtxt.height = 62.75;
         this.newshowtxt.width = 275.95;
         this.newshowtxt.wordWrap = true;
         this.newshowtxt.embedFonts = true;
         this.newshowtxt.htmlText = "<font face=\'FZCuYuan-M03S\' size=\'14\' color=\'#ffffff\'>" + showStr + "</font>";
         this.addChild(this.newshowtxt);
      }
      
      private function gClick(e:MouseEvent) : void
      {
         gc.dataObject.hasGetAlliance = true;
         gc.savedBuff.addBuff(SingleSavedBuff.BUFF_ALLIANCE_ATK,gc.honorData.allianceLevel * gc.dataObject.fifty,86400);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

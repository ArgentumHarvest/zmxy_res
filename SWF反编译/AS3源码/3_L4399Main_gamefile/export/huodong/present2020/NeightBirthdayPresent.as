package export.huodong.present2020
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class NeightBirthdayPresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn1:SimpleButton;
      
      public var gbtn2:SimpleButton;
      
      public var gbtn3:SimpleButton;
      
      private var gc:Config;
      
      public function NeightBirthdayPresent()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
         lqbtn.addEventListener("click",lqClick);
         gbtn1.addEventListener("click",gClick1);
         gbtn2.addEventListener("click",gClick2);
         gbtn3.addEventListener("click",gClick3);
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
         gbtn1.removeEventListener("click",gClick1);
         gbtn2.removeEventListener("click",gClick2);
         gbtn3.removeEventListener("click",gClick3);
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         if(gc.dataObject.hasPresent2020_neightBir == true || gc.dataObject.hasPresent2020_neightBir == "true")
         {
            gc.ts.setTxt("该存档已经领取过！");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(gc.allEquip.findByName("ptsrdg"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(gc.allEquip.findByName("ptsrdg"));
         }
         gc.ts.setTxt("成功领取 生日蛋糕x1",2.5,22);
         gc.stage.addChild(gc.ts);
         gc.dataObject.hasPresent2020_neightBir = true;
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function gClick1(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/mtag-84526"),"_blank");
      }
      
      private function gClick2(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://bbs.4399.cn/forums-mtag-84541"),"_blank");
      }
      
      private function gClick3(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://huodong2.4399.com/2020/zmxyonline/"),"_blank");
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("OPEN_HUODONG_INTERFACE"));
      }
   }
}

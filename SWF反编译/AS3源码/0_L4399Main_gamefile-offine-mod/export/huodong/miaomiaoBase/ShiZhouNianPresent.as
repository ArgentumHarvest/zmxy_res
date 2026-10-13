package export.huodong.miaomiaoBase
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   
   public class ShiZhouNianPresent extends Sprite
   {
       
      
      private var gc:Config;
      
      private var urlLoader:URLLoader;
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public function ShiZhouNianPresent()
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
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         if(gc.dataObject.hasPresent2021_tenBir == true || gc.dataObject.hasPresent2021_tenBir == "true")
         {
            gc.ts.setTxt("该存档已经领取过！");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"fys2",1);
            gc.player1.zblist.push(gc.allEquip.findByName("sssrdg2"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"fys2",1);
            gc.player2.zblist.push(gc.allEquip.findByName("sssrdg2"));
         }
         gc.dataObject.hasPresent2021_tenBir = true;
         gc.ts.setTxt("成功领取 大灵魂药水X1、十周年头衔X1、2级防御石X1");
         gc.stage.addChild(gc.ts);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
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

package export.huodong.gamebox
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import my.MyEquipObj;
   
   public class GameBoxActivity extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function GameBoxActivity()
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
         gbtn.addEventListener("click",gClick);
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
         gbtn.removeEventListener("click",gClick);
      }
      
      private function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-42704247.html"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlReuest:* = null;
         if(gc.dataObject.hasGetGameBoxActivity == true || gc.dataObject.hasGetGameBoxActivity == "true")
         {
            gc.ts.setTxt("该存档已经领取过！");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(this.judgeBackPack())
         {
            return;
         }
         var cid:String = this.dhtxt.text;
         for(var clen:uint = cid.length; clen-- > 0; )
         {
            cid = cid.replace(" ","");
         }
         if(cid != "")
         {
            gc.addActionMask("renewalse");
            urlLoader = new URLLoader();
            urlLoader.dataFormat = "text";
            urlLoader.addEventListener("complete",completeHandler);
            urlLoader.addEventListener("ioError",errorHandle);
            urlLoader.addEventListener("securityError",errorHandle);
            urlReuest = new URLRequest("https://huodong2.4399.com/comm/downloadwap/api/game_api.php?game=zmxy&code=" + cid);
            urlLoader.load(urlReuest);
         }
      }
      
      private function completeHandler(e:Event) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandle);
         urlLoader.removeEventListener("securityError",errorHandle);
         trace("urlLoader.data -->>" + urlLoader.data);
         var ary:Array = String(urlLoader.data).split("|");
         if(ary[0] == "1")
         {
            this.getGameBoxPresent();
            gc.dataObject.hasGetGameBoxActivity = true;
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            if(ary[1] == "001")
            {
               gc.ts.setTxt("活动还没开始");
            }
            else if(ary[1] == "002")
            {
               gc.ts.setTxt("活动已经结束");
            }
            else if(ary[1] == "003")
            {
               gc.ts.setTxt("未登录");
            }
            else if(ary[1] == "004")
            {
               gc.ts.setTxt("兑换码无效");
            }
            else if(ary[1] == "005")
            {
               gc.ts.setTxt("参数有误");
            }
            else if(ary[1] == "006")
            {
               gc.ts.setTxt("您已经兑换过了");
            }
            else if(ary[1] == "007")
            {
               gc.ts.setTxt("请确保活动账号与兑换账号一致");
            }
            else if(ary[1] == "008")
            {
               gc.ts.setTxt("您输入的激活码有误，请重新输入");
            }
            else
            {
               gc.ts.setTxt("领取失败");
            }
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function judgeBackPack() : Boolean
      {
         var str:* = null;
         str = null;
         var exictmask:* = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.player1.getSomeOneEquipNumberByName("wptlz") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            else if(gc.player1.getSomeOneEquipNumberByName("wpllz") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            else if(gc.player1.getSomeOneEquipNumberByName("wphlz") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            else if(gc.player1.getSomeOneEquipNumberByName("wpqhs1") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            else if(gc.player1.getSomeOneEquipNumberByName("wplvdyl") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.player1.petsAry.length >= 10)
               {
                  str += "宠物栏已满";
               }
            }
            else if(gc.player1.petsAry.length >= 5)
            {
               str += "宠物栏已满";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.player2.getSomeOneEquipNumberByName("wptlz") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player2.getSomeOneEquipNumberByName("wpllz") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player2.getSomeOneEquipNumberByName("wphlz") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player2.getSomeOneEquipNumberByName("wpqhs1") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player2.getSomeOneEquipNumberByName("wplvdyl") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.gameVip.getVipLevel() >= 3)
               {
                  if(gc.player2.petsAry.length >= 10)
                  {
                     str += "宠物栏已满";
                  }
               }
               else if(gc.player2.petsAry.length >= 5)
               {
                  str += "宠物栏已满";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            exictmask = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
            if(exictmask)
            {
               gc.stage.removeChild(exictmask);
               exictmask = null;
            }
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      protected function getGameBoxPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(this.getHeHuaEquip());
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs1",3);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",10);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(this.getHeHuaEquip());
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs1",3);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",10);
         }
         gc.ts.setTxt("成功领取 慈心妙莲、土灵珠x1、雷灵珠x1、火灵珠x1、一级强化石x3、龙女的眼泪x10",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      private function getHeHuaEquip() : MyEquipObj
      {
         var equip:MyEquipObj = gc.allEquip.findByName("hehua");
         equip.setEupdata(2.4);
         return equip;
      }
      
      private function errorHandle(e:Event) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandle);
         urlLoader.removeEventListener("securityError",errorHandle);
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

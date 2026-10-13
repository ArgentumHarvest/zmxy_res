package export.huodong.newyear
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import my.MyEquipObj;
   
   public class NewYearPresent2015 extends Sprite
   {
       
      
      private var gc:Config;
      
      private var urlLoader:URLLoader;
      
      public var xbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public function NewYearPresent2015()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-45791575.html"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var str:* = null;
         str = null;
         var exictmask:* = null;
         var urlReuest:* = null;
         if(gc.dataObject.hasGetNewYearPresent2015 == true || gc.dataObject.hasGetNewYearPresent2015 == "true")
         {
            gc.ts.setTxt("该存档已经领取过！");
            gc.stage.addChild(gc.ts);
            return;
         }
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               str += "装备栏已满  ";
            }
            if(gc.player1.getSomeOneEquipNumberByName("xnhdl") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(gc.player1.getSomeOneEquipNumberByName("sbjyd") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(gc.player1.szlist.length >= gc.player1.getMax())
            {
               str += "时装栏已满 ";
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
               if(gc.player2.zblist.length >= gc.player2.getMax())
               {
                  str += "装备栏已满  ";
               }
               if(gc.player2.getSomeOneEquipNumberByName("xnhdl") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.player2.getSomeOneEquipNumberByName("sbjyd") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.player2.szlist.length >= gc.player2.getMax())
               {
                  str += "时装栏已满 ";
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
            urlReuest = new URLRequest("https://huodong.4399.com/2015/2015chunjie/api.php?uid=" + gc.logInfo.uid + "&type=1&code=" + cid);
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
         var rcode:String = urlLoader.data + "";
         if(rcode == "10001")
         {
            gc.ts.setTxt("参数传到不完整");
         }
         else if(rcode == "10002")
         {
            gc.ts.setTxt("玩家没有领取过该类别的激活码");
         }
         else if(rcode == "10003")
         {
            gc.ts.setTxt("激活码错误");
         }
         else if(rcode == "10004")
         {
            this.getPresent();
            gc.dataObject.hasGetNewYearPresent2015 = true;
            gc.ts.setTxt("成功领取 新年快乐头衔x1、新年红灯笼x1、牛魔王时装x1、双倍经验丹x1");
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            gc.ts.setTxt("返回码错误");
         }
         gc.stage.addChild(gc.ts);
      }
      
      private function getPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.szlist.push(this.getSZEquipment());
            gc.player1.zblist.push(this.getNewYear());
            gc.putQhsInBackPack(gc.player1,"xnhdl",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.szlist.push(this.getSZEquipment());
            gc.player2.zblist.push(this.getNewYear());
            gc.putQhsInBackPack(gc.player2,"xnhdl",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
         }
      }
      
      private function getNewYear() : MyEquipObj
      {
         return gc.allEquip.findByName("_zmxyptxnkl2014");
      }
      
      private function getSZEquipment() : MyEquipObj
      {
         var nmwsz:MyEquipObj = gc.allEquip.findByName("ptnmwsz");
         nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
         return nmwsz;
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
         gc.eventManger.dispatchEvent(new CommonEvent("OPEN_HUODONG_INTERFACE"));
      }
   }
}

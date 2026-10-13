package export.huodong.weixin
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
   
   public class WeiXinInterface4 extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function WeiXinInterface4()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-48129008.html"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlReuest:* = null;
         if(gc.dataObject.hasWeiXin4Activity == true || gc.dataObject.hasWeiXin4Activity == "true")
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
            urlReuest = new URLRequest("https://huodong2.4399.com/comm/zmxy3/api.php?cid=1&code=" + cid);
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
            gc.dataObject.hasWeiXin4Activity = true;
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            if(ary[1] == "01")
            {
               gc.ts.setTxt("未登录");
            }
            else if(ary[1] == "02")
            {
               gc.ts.setTxt("参数有误");
            }
            else if(ary[1] == "03")
            {
               gc.ts.setTxt("同一帐号连续错误超过20次");
            }
            else if(ary[1] == "04")
            {
               gc.ts.setTxt("该存档已经兑换过");
            }
            else if(ary[1] == "05")
            {
               gc.ts.setTxt("兑换码未领过");
            }
            else if(ary[1] == "06")
            {
               gc.ts.setTxt("已过期");
            }
            else if(ary[1] == "07")
            {
               gc.ts.setTxt("兑换码已被其他人领取");
            }
            else if(ary[1] == "08")
            {
               gc.ts.setTxt("已过期");
            }
            else
            {
               gc.ts.setTxt("其它错误");
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
            if(gc.player1.getSomeOneEquipNumberByName("xns3") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            else if(gc.player1.getSomeOneEquipNumberByName("kly3") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               str += "装备栏已满 ";
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
               if(gc.player2.getSomeOneEquipNumberByName("xns3") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player2.getSomeOneEquipNumberByName("kly3") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.player2.zblist.length >= gc.player2.getMax())
               {
                  str += "装备栏已满 ";
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
         }
         return bool;
      }
      
      protected function getGameBoxPresent() : void
      {
         var nmwsz:* = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(gc.allEquip.findByName("_4399ptsjwj"));
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(gc.allEquip.findByName("_4399ptsjwj"));
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 4399手机玩家头衔x1、三级仙女石x1、三级昆仑玉x1、优秀神秘商人装x1",2.5,24);
         gc.stage.addChild(gc.ts);
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

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
   import petInfo.PetInfo;
   
   public class WeiXinInterface6 extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function WeiXinInterface6()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-56780122"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlReuest:* = null;
         if(gc.dataObject.hasWeiXin7Activity == true || gc.dataObject.hasWeiXin7Activity == "true")
         {
            gc.ts.setTxt("该存档已经领取过！");
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
            urlReuest = new URLRequest("https://huodong2.4399.com/comm/zmxy3/api.php?cid=9&code=" + cid);
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
            gc.dataObject.hasWeiXin7Activity = true;
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
               gc.ts.setTxt("没有这个兑换码");
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
      
      protected function getGameBoxPresent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gc.player1.petsAry.push(this.getYMPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gc.player2.petsAry.push(this.getYMPet());
         }
         gc.ts.setTxt("成功领取 炎马宝宝X1、造梦英雄x1、土灵珠X1、3级强化石X1、孟婆药剂X1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      private function getYMPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("roomhorse1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1000);
         pif.setmpQuality(1200);
         pif.setatkQuality(1200);
         pif.setdefQuality(600);
         pif.setHp(700);
         pif.setMp(800);
         pif.setAtk(50);
         pif.setDef(10);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
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

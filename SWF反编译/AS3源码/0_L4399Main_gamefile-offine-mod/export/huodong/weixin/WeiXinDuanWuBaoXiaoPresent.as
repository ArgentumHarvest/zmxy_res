package export.huodong.weixin
{
   import com.adobe.crypto.MD5;
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class WeiXinDuanWuBaoXiaoPresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function WeiXinDuanWuBaoXiaoPresent()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-56843596"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlReuest:* = null;
         if(gc.dataObject.hasDWWeiXinBaoXiaoActivity == true || gc.dataObject.hasDWWeiXinBaoXiaoActivity == "true")
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
            urlReuest = new URLRequest("https://huodong.4399.com/baoxiao/happysummerday/api/server.php?ac=exchange&cid=1&code=" + cid + "&secure=" + MD5.hash(cid + "@#dfl3892$#90EDSF&%$"));
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
         if(urlLoader.data == "1" || urlLoader.data == 1)
         {
            gc.dataObject.hasDWWeiXinBaoXiaoActivity = true;
            this.getGameBoxPresent();
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else if(urlLoader.data == "01")
         {
            gc.ts.setTxt("加密验证失败");
            gc.stage.addChild(gc.ts);
         }
         else if(urlLoader.data == "02")
         {
            gc.ts.setTxt("已经被领取");
            gc.stage.addChild(gc.ts);
         }
         else if(urlLoader.data == "03")
         {
            gc.ts.setTxt("激活码不存在");
            gc.stage.addChild(gc.ts);
         }
         else if(urlLoader.data == "04")
         {
            gc.ts.setTxt("请求超时");
            gc.stage.addChild(gc.ts);
         }
      }
      
      protected function getGameBoxPresent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝X1、阴阳斩龙剑X1、3级强化石X1、3级仙女石X1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      private function getJPQLPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("dragon1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1400);
         pif.setmpQuality(700);
         pif.setatkQuality(1400);
         pif.setdefQuality(500);
         pif.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 200));
         pif.setMp(150 + Math.round(RandomControllor.getIns().getRandom() * 50));
         pif.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 15));
         pif.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 6));
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

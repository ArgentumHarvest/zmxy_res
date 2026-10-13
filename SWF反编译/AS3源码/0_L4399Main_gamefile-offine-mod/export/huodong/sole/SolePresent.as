package export.huodong.sole
{
   import com.adobe.crypto.MD5;
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class SolePresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      protected var urlLoader:URLLoader;
      
      protected var gc:Config;
      
      public var typeId:int = 4399130;
      
      public function SolePresent()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      protected function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
         lqbtn.addEventListener("click",lqClick);
         gbtn.addEventListener("click",gClick);
      }
      
      protected function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
         gbtn.removeEventListener("click",gClick);
      }
      
      protected function errorHandle(e:Event) : void
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
      
      protected function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("OPEN_HUODONG_INTERFACE"));
      }
      
      protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-55408441"),"_blank");
      }
      
      protected function lqClick(e:MouseEvent) : void
      {
         var urlVariables:* = null;
         var key:* = null;
         var urlReuest:* = null;
         if(gc.dataObject.hasGetSolePresent3 == true || gc.dataObject.hasGetSolePresent3 == "true")
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
            urlVariables = new URLVariables();
            urlVariables.uid = gc.logInfo.uid;
            urlVariables.type = typeId;
            urlVariables.code = cid;
            key = MD5.hash(MD5.hash("asdakjapsdfajslkjasdkWPUls" + urlVariables.uid + "" + urlVariables.type + "" + urlVariables.code));
            urlVariables.key = key;
            urlReuest = new URLRequest("https://huodong.4399.com/2016/djyx/api.php?" + RandomControllor.getIns().getRandom());
            urlReuest.method = "POST";
            urlReuest.data = urlVariables;
            urlLoader.load(urlReuest);
         }
      }
      
      protected function completeHandler(e:Event) : void
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
         switch(int(urlLoader.data))
         {
            case 10000:
               gc.ts.setTxt("领取失败,参数填写不完整");
               break;
            case 10001:
               gc.ts.setTxt("领取失败,礼包id不正确");
               break;
            case 10002:
               gc.ts.setTxt("领取失败,校验码不正确");
               break;
            case 10003:
               gc.ts.setTxt("用户没有领取过相关类型的礼包");
               break;
            case 10004:
               gc.ts.setTxt("礼包的激活码没有和用户绑定，或者激活码有误",2.5,22);
               break;
            case 20000:
               this.getPresent();
               gc.dataObject.hasGetSolePresent3 = true;
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
               break;
            default:
               gc.ts.setTxt("未知错误code =" + urlLoader.data);
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function getPresent() : void
      {
         var smsrsz:* = null;
         smsrsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpslz");
            gc.player1.plist.push(gc.allEquip.findByName("p_cygsjl"));
            smsrsz = gc.allEquip.findByName("_jsyxyx");
            gc.player1.zblist.push(smsrsz);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cygsjl"));
            smsrsz = gc.allEquip.findByName("_jsyxyx");
            gc.player2.zblist.push(smsrsz);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 玄武宝宝x1、钢石精灵x1、水灵珠x1、救世英雄头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      private function getJpGuiBuPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("turtle1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1500);
         pif.setmpQuality(1000);
         pif.setatkQuality(1200);
         pif.setdefQuality(700);
         pif.setHp(300 + Math.round(RandomControllor.getIns().getRandom() * 300));
         pif.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
         pif.setAtk(10 + Math.round(RandomControllor.getIns().getRandom() * 15));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
   }
}

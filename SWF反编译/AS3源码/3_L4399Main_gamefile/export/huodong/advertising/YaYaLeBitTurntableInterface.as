package export.huodong.advertising
{
   import com.adobe.crypto.MD5;
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class YaYaLeBitTurntableInterface extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public var lqbtn:SimpleButton;
      
      public var ppmc:Sprite;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      private var random:int = 1;
      
      public function YaYaLeBitTurntableInterface()
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
         lqbtn.addEventListener("click",lqClick);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlVariables:* = null;
         var token:* = null;
         var urlReuest:* = null;
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
            urlVariables.activation = cid;
            urlVariables.product_id = 1214;
            urlVariables.uid = gc.logInfo.uid;
            urlVariables.type = "1";
            token = MD5.hash(urlVariables.activation + urlVariables.product_id + urlVariables.type + urlVariables.uid + "b83e86ee2246462f0ac0a471a1f4ec0c");
            urlVariables.token = token;
            urlReuest = new URLRequest("https://my.4399.com/jifen/api-apply");
            urlReuest.method = "POST";
            urlReuest.data = urlVariables;
            urlLoader.load(urlReuest);
         }
         else
         {
            gc.ts.setTxt("请输入兑换码");
            gc.stage.addChild(gc.ts);
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
         var jObj:* = JSON.parse(urlLoader.data);
         if(jObj.code == 100)
         {
            this.turntableGo();
         }
         else
         {
            if(jObj.msg != "")
            {
               gc.ts.setTxt(jObj.msg);
            }
            else
            {
               gc.ts.setTxt("领取失败");
            }
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function turntableGo() : void
      {
         var rand:Number = RandomControllor.getIns().getRandom();
         if(rand < 0.33)
         {
            random = 1;
         }
         else if(rand < 0.66)
         {
            random = 2;
         }
         else
         {
            random = 3;
         }
         var ro:int = 720;
         if(random == 1)
         {
            ro = 720;
         }
         else if(random == 2)
         {
            ro = 840;
         }
         else if(random == 3)
         {
            ro = 960;
         }
         TweenMax.to(ppmc,2,{
            "rotation":ro,
            "onComplete":doComplete
         });
      }
      
      private function doComplete() : void
      {
         this.getPresentById(this.random);
      }
      
      private function getPresentById(_pid:int) : void
      {
         switch(int(_pid) - 1)
         {
            case 0:
               this.firstPresent();
               break;
            case 1:
               this.secondPresent();
               break;
            case 2:
               this.thirdPresent();
         }
         if(_pid == 1 || _pid == 2 || _pid == 3)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
      }
      
      private function firstPresent() : void
      {
         var str:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getroomhorsePet());
            str = "成功领取 炎马x1";
            if(gc.player1.getSomeOneEquipNumberByName("yysn") <= 0)
            {
               gc.putQhsInBackPack(gc.player1,"yysn");
               str = "成功领取 炎马x1、伢牙神弩x1";
            }
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function secondPresent() : void
      {
         var fashion1:* = null;
         var str:* = null;
         if(gc.player1.roleid > 0)
         {
            fashion1 = gc.allEquip.findByName("ptzlwsz");
            fashion1.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(fashion1);
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"wpst_1",1);
            gc.putQhsInBackPack(gc.player1,"kly1",1);
            str = "成功领取转轮王装x1、3级强化石x1、一重神铁x1、1级昆仑玉x1";
            if(gc.player1.getSomeOneEquipNumberByName("yysn") <= 0)
            {
               gc.putQhsInBackPack(gc.player1,"yysn");
               str = "成功领取转轮王装x1、3级强化石x1、1级昆仑玉x1、一重神铁x1、伢牙神弩x1";
            }
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function thirdPresent() : void
      {
         var nmwsz:* = null;
         var str:* = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
            gc.putQhsInBackPack(gc.player1,"wpsh_1",1);
            str = "成功领取牛魔王装x1、孟婆药剂x1、1级仙女石x1、一重神火x1";
            if(gc.player1.getSomeOneEquipNumberByName("yysn") <= 0)
            {
               gc.putQhsInBackPack(gc.player1,"yysn");
               str = "成功领取牛魔王装x1、孟婆药剂x1、1级仙女石x1、一重神火x1、伢牙神弩x1";
            }
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getroomhorsePet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("roomhorse1",1);
         pif.setperception(gc.dataObject.one + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.four));
         pif.setwarpower(gc.dataObject.one + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
         pif.settechnique(gc.dataObject.one + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
         pif.sethpQuality((700 + Math.round(RandomControllor.getIns().getRandom() * 500)) * 1.3);
         pif.setmpQuality((550 + Math.round(RandomControllor.getIns().getRandom() * 440)) * 1.3);
         pif.setatkQuality((1000 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
         pif.setdefQuality((200 + Math.round(RandomControllor.getIns().getRandom() * 200)) * 1.3);
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
      
      private function xClick(e:Event) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

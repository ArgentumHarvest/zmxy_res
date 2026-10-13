package export.huodong.advertising
{
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
   
   public class YaYaLeTenYearPresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function YaYaLeTenYearPresent()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-47337528.html"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlVariables:* = null;
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
            urlVariables.product_id = 11668;
            urlVariables.sn = cid;
            urlReuest = new URLRequest("https://my.4399.com/credit/sn-hdusesn");
            urlReuest.method = "POST";
            urlReuest.data = urlVariables;
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
         var jObj:* = JSON.parse(urlLoader.data);
         if(jObj.code == 100)
         {
            if(jObj.result == 1)
            {
               gc.ts.setTxt("成功领取 伢牙乐十周年高级礼包");
               this.getPresent1();
            }
            else if(jObj.result == 2)
            {
               gc.ts.setTxt("成功领取 伢牙乐十周年普通礼包");
               this.getPresent2();
            }
         }
         else
         {
            gc.ts.setTxt(jObj.msg);
         }
         gc.stage.addChild(gc.ts);
      }
      
      private function getPresent2() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs1",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs1",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function getPresent1() : void
      {
         var nmwsz:* = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gc.player1.plist.push(gc.allEquip.findByName("p_cygsjl"));
            gc.putQhsInBackPack(gc.player1,"gjs1",1);
            gc.putQhsInBackPack(gc.player1,"fys1",1);
            gc.putQhsInBackPack(gc.player1,"sms1",1);
            gc.putQhsInBackPack(gc.player1,"mfs1",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs1",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
            gc.player2.plist.push(gc.allEquip.findByName("p_cygsjl"));
            gc.putQhsInBackPack(gc.player2,"gjs1",1);
            gc.putQhsInBackPack(gc.player2,"fys1",1);
            gc.putQhsInBackPack(gc.player2,"sms1",1);
            gc.putQhsInBackPack(gc.player2,"mfs1",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs1",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function getJpGuiBuPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("turtle1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1600);
         pif.setmpQuality(1000);
         pif.setatkQuality(1000);
         pif.setdefQuality(700);
         pif.setHp(300 + Math.round(RandomControllor.getIns().getRandom() * 300));
         pif.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
         pif.setAtk(10 + Math.round(RandomControllor.getIns().getRandom() * 15));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
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
         gc.eventManger.dispatchEvent(new CommonEvent("OPEN_HUODONG_INTERFACE"));
      }
   }
}

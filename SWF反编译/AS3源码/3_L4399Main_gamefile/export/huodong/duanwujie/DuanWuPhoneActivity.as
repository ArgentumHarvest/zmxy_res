package export.huodong.duanwujie
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
   import petInfo.PetInfo;
   
   public class DuanWuPhoneActivity extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public var btn4:SimpleButton;
      
      public var btn6:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      protected var urlLoader:URLLoader;
      
      protected var gc:Config;
      
      public function DuanWuPhoneActivity()
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
         btn4.addEventListener("click",zhongzi4Click);
         btn6.addEventListener("click",zhongzi6Click);
         btn4.dispatchEvent(new MouseEvent("click"));
      }
      
      protected function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
         gbtn.removeEventListener("click",gClick);
         btn4.removeEventListener("click",zhongzi4Click);
         btn6.removeEventListener("click",zhongzi6Click);
      }
      
      protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-41430865.html"),"_blank");
      }
      
      private function zhongzi4Click(e:MouseEvent) : void
      {
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "btn4";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
         gc.dataObject.usewhichlb = 4;
      }
      
      private function zhongzi6Click(e:MouseEvent) : void
      {
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "btn6";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
         gc.dataObject.usewhichlb = 16;
      }
      
      private function judge4() : String
      {
         var bool:Boolean = false;
         var str:String = "1P";
         if(gc.player1.roleid > 0)
         {
            if(gc.player1.getSomeOneEquipNumberByName("jyys") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            else if(gc.player1.getSomeOneEquipNumberByName("wplvdyl") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            else if(gc.player1.getSomeOneEquipNumberByName("wptm") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            else if(gc.player1.getSomeOneEquipNumberByName("wpxt") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
         }
         if(str != "1P")
         {
            bool = true;
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.player2.getSomeOneEquipNumberByName("jyys") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player2.getSomeOneEquipNumberByName("wplvdyl") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player2.getSomeOneEquipNumberByName("wptm") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player2.getSomeOneEquipNumberByName("wpxt") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
            }
         }
         return str;
      }
      
      private function judge16() : String
      {
         var bool:Boolean = false;
         var str:String = "1P";
         if(gc.player1.roleid > 0)
         {
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
            if(gc.player1.getSomeOneEquipNumberByName("wpxt") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            else if(gc.player1.getSomeOneEquipNumberByName("wpygs") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
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
               if(gc.player2.getSomeOneEquipNumberByName("wpxt") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               else if(gc.player2.getSomeOneEquipNumberByName("wpygs") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
            }
         }
         return str;
      }
      
      protected function lqClick(e:MouseEvent) : void
      {
         var exictmask:* = null;
         exictmask = null;
         var urlVariables:* = null;
         var key:* = null;
         var token:* = null;
         var urlReuest:* = null;
         var bool:Boolean = false;
         var str:String = "";
         if(this.lastBtn == "btn4")
         {
            str = this.judge4();
            if(!(str == "1P" || str == "2P"))
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
         }
         else
         {
            str = this.judge16();
            if(!(str == "1P" || str == "2P"))
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
            urlVariables.activation = cid;
            urlVariables.uid = gc.logInfo.uid;
            urlVariables.type = "1";
            key = "";
            if(this.lastBtn == "btn4")
            {
               key = "ddd9624008d5a0e2d457bf560a04936b";
               urlVariables.product_id = 1288;
            }
            else
            {
               key = "2d94528bd1710c2c39699dad07cc2527";
               urlVariables.product_id = 1286;
            }
            token = MD5.hash(urlVariables.activation + urlVariables.product_id + urlVariables.type + urlVariables.uid + key);
            urlVariables.token = token;
            urlReuest = new URLRequest("https://my.4399.com/jifen/api-apply");
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
         trace("urlLoader.data -->>" + urlLoader.data);
         var jObj:* = JSON.parse(urlLoader.data);
         if(jObj.code == 100)
         {
            this.getPresent();
         }
         else
         {
            if(jObj.msg != "")
            {
               if(jObj.code == 108)
               {
                  gc.ts.setTxt("今天的礼包已经发完，明天再来吧");
               }
               else
               {
                  gc.ts.setTxt(jObj.msg);
               }
            }
            else
            {
               gc.ts.setTxt("领取失败");
            }
            gc.stage.addChild(gc.ts);
         }
      }
      
      protected function getPresent() : void
      {
         if(gc.dataObject.usewhichlb == 16)
         {
            this.get16Present();
         }
         else if(gc.dataObject.usewhichlb == 4)
         {
            this.get4Present();
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function get4Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"jyys",10);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",10);
            gc.putQhsInBackPack(gc.player1,"wptm",40);
            gc.putQhsInBackPack(gc.player1,"wpxt",40);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"jyys",10);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",10);
            gc.putQhsInBackPack(gc.player2,"wptm",40);
            gc.putQhsInBackPack(gc.player2,"wpxt",40);
         }
         gc.ts.setTxt("经验药水x10、龙女的眼泪x10、玄铁x40、檀木x40");
         gc.stage.addChild(gc.ts);
      }
      
      private function get16Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getBHPet());
            gc.putQhsInBackPack(gc.player1,"wpxt",99);
            gc.putQhsInBackPack(gc.player1,"wpygs",5);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getBHPet());
            gc.putQhsInBackPack(gc.player2,"wpxt",99);
            gc.putQhsInBackPack(gc.player2,"wpygs",5);
         }
         gc.dataObject.worldtransfromTimes += 10;
         gc.ts.setTxt("白虎宝宝x1、玄铁x99、传送翅膀x10、摇光石x5");
         gc.stage.addChild(gc.ts);
      }
      
      private function getBHPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("tigress1",1);
         pif.setperception(3 + Math.round(RandomControllor.getIns().getRandom() * 2));
         pif.setwarpower(3 + Math.round(RandomControllor.getIns().getRandom()));
         pif.settechnique(3 + Math.round(RandomControllor.getIns().getRandom()));
         pif.sethpQuality(1300);
         pif.setmpQuality(1040);
         pif.setatkQuality(1300);
         pif.setdefQuality(520);
         pif.setHp(500);
         pif.setMp(150);
         pif.setAtk(30);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
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
   }
}

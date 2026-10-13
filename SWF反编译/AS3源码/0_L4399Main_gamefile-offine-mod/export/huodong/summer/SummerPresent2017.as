package export.huodong.summer
{
   import com.adobe.crypto.MD5;
   import config.Config;
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
   
   public class SummerPresent2017 extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function SummerPresent2017()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-57401589"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlVariables:* = null;
         var urlReuest:* = null;
         if(gc.dataObject.hasSummer2017 == true || gc.dataObject.hasSummer2017 == "true")
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
            urlVariables.type = 2;
            urlVariables.code = cid;
            urlVariables.key = MD5.hash(MD5.hash("asdakjapsdfajslkjasdkWPUls" + gc.logInfo.uid + 2 + cid));
            urlReuest = new URLRequest("https://huodong.4399.com/2017/ndyx/api.php");
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
         switch(urlLoader.data + "")
         {
            case "10000":
               gc.ts.setTxt("参数填写不完整",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "10001":
               gc.ts.setTxt("礼包id不正确",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "10002":
               gc.ts.setTxt("礼包id不正确",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "10003":
               gc.ts.setTxt("激活码有误",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "20000":
               this.getGameBoxPresent();
               gc.dataObject.hasSummer2017 = true;
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
         }
      }
      
      protected function getGameBoxPresent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wplvdyl",10);
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wplvdyl",10);
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1、阴阳斩龙剑x1，龙女的眼泪x10，龙王令x1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      private function getQLPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("dragon1",1);
         pif.setperception(3 + Math.round(RandomControllor.getIns().getRandom() * 2));
         pif.setwarpower(3 + Math.round(RandomControllor.getIns().getRandom()));
         pif.settechnique(3 + Math.round(RandomControllor.getIns().getRandom()));
         pif.sethpQuality(1430);
         pif.setmpQuality(780);
         pif.setatkQuality(1430);
         pif.setdefQuality(520);
         pif.setHp(400);
         pif.setMp(200);
         pif.setAtk(30);
         pif.setDef(8);
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

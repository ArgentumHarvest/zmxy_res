package export.huodong.kabu
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class ReceiveKaBuPacks extends Sprite
   {
       
      
      public var recbtn:SimpleButton;
      
      public var inptxt:TextField;
      
      public var xbtn:SimpleButton;
      
      private var gc:Config;
      
      private var urlLoader:URLLoader;
      
      public function ReceiveKaBuPacks()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         recbtn.addEventListener("click",recClick);
         xbtn.addEventListener("click",back);
      }
      
      private function removed(e:Event) : void
      {
         recbtn.removeEventListener("click",recClick);
         xbtn.removeEventListener("click",back);
      }
      
      private function recClick(e:MouseEvent) : void
      {
         var cid:* = null;
         var clen:* = 0;
         var urlVariables:* = null;
         var urlReuest:* = null;
         cid = this.inptxt.text;
         if(cid != "")
         {
            urlLoader = new URLLoader();
            urlLoader.dataFormat = "text";
            urlLoader.addEventListener("complete",completeHandler);
            cid = inptxt.text;
            for(clen = uint(cid.length); clen-- > 0; )
            {
               cid = cid.replace(" ","");
            }
            urlVariables = new URLVariables();
            urlVariables.uid = gc.logInfo.uid;
            urlVariables.cardId = cid;
            urlReuest = new URLRequest("https://php.wanwan4399.com/api/check_card_api.php");
            urlReuest.method = "POST";
            urlReuest.data = urlVariables;
            urlLoader.load(urlReuest);
         }
      }
      
      private function completeHandler(e:Event) : void
      {
         urlLoader.removeEventListener("complete",completeHandler);
         var exictmask:Sprite = this.stage.getChildByName("execuitionActionreceiveKaBu") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         var jObj:* = JSON.parse(urlLoader.data);
         this.checkOk(int(jObj["state"]));
      }
      
      private function checkOk(state:uint) : void
      {
         if(state == 0)
         {
            this.putGiftsInPack();
         }
         else if(state == 1)
         {
            gc.ts.setTxt("该卡号已经领取过奖励");
            gc.stage.addChild(gc.ts);
         }
         else if(state == 2)
         {
            gc.ts.setTxt("领取的卡号不存在");
            gc.stage.addChild(gc.ts);
         }
         else if(state == 3)
         {
            gc.ts.setTxt("您的账号已经领取过奖励");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function putGiftsInPack() : void
      {
         var pet:PetInfo = new PetInfo();
         pet.setPetNameAndLevel("ufo1",1);
         var nmwsz:MyEquipObj = gc.allEquip.findByName("ptnmwsz");
         nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs1",12);
            gc.putQhsInBackPack(gc.player1,"mpyj");
            gc.player1.szlist.push(nmwsz);
            gc.player1.petsAry.push(pet);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs1",12);
            gc.putQhsInBackPack(gc.player2,"mpyj");
            gc.player2.szlist.push(nmwsz);
            gc.player2.petsAry.push(pet);
         }
         gc.ts.setTxt("领取成功");
         gc.stage.addChild(gc.ts);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function back(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

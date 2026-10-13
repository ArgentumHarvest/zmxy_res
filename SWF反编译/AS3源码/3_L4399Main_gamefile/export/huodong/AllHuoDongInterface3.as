package export.huodong
{
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import manager.PayManager;
   
   public class AllHuoDongInterface3 extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var inputtxt:TextField;
      
      public var excbtn:SimpleButton;
      
      public var intobtn:SimpleButton;
      
      public var btncost:MovieClip;
      
      public var showtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      public function AllHuoDongInterface3()
      {
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         xbtn.addEventListener("click",xClick);
         excbtn.addEventListener("click",excClick);
         intobtn.addEventListener("click",intoClick);
         this.showtxt.text = gc.dataObject.challengeChildrensTimes + "";
         btncost.buttonMode = true;
         if(gc.dataObject.challengeChildrensTimes <= 0)
         {
            btncost.gotoAndStop(1);
            btncost.addEventListener("click",costClick);
         }
         else
         {
            btncost.gotoAndStop(2);
            btncost.removeEventListener("click",costClick);
         }
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         excbtn.removeEventListener("click",excClick);
         intobtn.removeEventListener("click",intoClick);
         btncost.removeEventListener("click",costClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      private function excClick(e:MouseEvent) : void
      {
         var cid:* = null;
         var clen:* = 0;
         var urlVariables:* = null;
         var urlReuest:* = null;
         cid = this.inputtxt.text;
         if(cid != "")
         {
            urlLoader = new URLLoader();
            urlLoader.dataFormat = "text";
            urlLoader.addEventListener("complete",completeHandler);
            cid = inputtxt.text;
            for(clen = uint(cid.length); clen-- > 0; )
            {
               cid = cid.replace(" ","");
            }
            urlVariables = new URLVariables();
            urlVariables.ac = "check";
            urlVariables.code = cid;
            urlVariables.game = "zmxy";
            urlReuest = new URLRequest("https://huodong2.4399.com/2012/liwu/liwu.php");
            urlReuest.method = "POST";
            urlReuest.data = urlVariables;
            urlLoader.load(urlReuest);
         }
      }
      
      private function completeHandler(e:Event) : void
      {
         urlLoader.removeEventListener("complete",completeHandler);
         trace("urlLoader.data -->>" + urlLoader.data);
         var ary:Array = String(urlLoader.data).split("|");
         if(ary[0] == "1")
         {
            if(gc.dataObject.hasChildrensDay == false || gc.dataObject.hasChildrensDay == "false")
            {
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wphtd");
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wphtd");
               }
               gc.dataObject.hasChildrensDay = true;
               gc.ts.setTxt("领取成功");
               gc.stage.addChild(gc.ts);
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
            }
            else
            {
               gc.ts.setTxt("该存档已经领取过！");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(ary[1] == "001")
         {
            gc.ts.setTxt("活动还没开始");
            gc.stage.addChild(gc.ts);
         }
         else if(ary[1] == "002")
         {
            gc.ts.setTxt("活动已经结束");
            gc.stage.addChild(gc.ts);
         }
         else if(ary[1] == "003")
         {
            gc.ts.setTxt("未登录");
            gc.stage.addChild(gc.ts);
         }
         else if(ary[1] == "004")
         {
            gc.ts.setTxt("兑换码无效");
            gc.stage.addChild(gc.ts);
         }
         else
         {
            gc.ts.setTxt("领取失败");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function intoClick(e:MouseEvent) : void
      {
         gc.ts.setTxt("活动已结束");
         gc.stage.addChild(gc.ts);
      }
      
      private function costClick(e:MouseEvent) : void
      {
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         this.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         var enough:Boolean = true;
         if(gc.gameVip.dataObject.lastMoney < 200)
         {
            gc.ts.setTxt("账户余额不足");
            gc.stage.addChild(gc.ts);
            enough = false;
         }
         gc.pay.money = 200;
         if(enough)
         {
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(2,"道具2",gc.pay.money,1);
               gc.lastPaymentString = "AllHuoDongInterface3";
               gc.addActionMask("renewalse");
            }
         }
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != "AllHuoDongInterface3")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.gameVip.dataObject.lastMoney = e.data[0];
         gc.lastPaymentString = "";
         gc.dataObject.challengeChildrensTimes++;
         btncost.gotoAndStop(2);
         btncost.removeEventListener("click",costClick);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         this.intoChildDuplicate();
      }
      
      private function paymentFail(e:CommonEvent) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
      }
      
      private function intoChildDuplicate() : void
      {
         if(gc.dataObject.challengeChildrensTimes > 0)
         {
            gc.curStageAndCurLevel.curStage = 15;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.dataObject.challengeChildrensTimes--;
            gc.eventManger.dispatchEvent(new CommonEvent("ChanllengeBossInster"));
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("您的挑战次数已经用完");
            gc.stage.addChild(gc.ts);
         }
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

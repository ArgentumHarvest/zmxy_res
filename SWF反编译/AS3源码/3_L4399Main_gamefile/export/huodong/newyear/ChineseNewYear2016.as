package export.huodong.newyear
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import manager.PayManager;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class ChineseNewYear2016 extends Sprite
   {
       
      
      public var backbtn:SimpleButton;
      
      public var bigRedPack:SimpleButton;
      
      public var retroactiveBtn:SimpleButton;
      
      public var b7:MovieClip;
      
      public var b8:MovieClip;
      
      public var b9:MovieClip;
      
      public var b10:MovieClip;
      
      public var b11:MovieClip;
      
      public var b12:MovieClip;
      
      public var b13:MovieClip;
      
      public var b14:MovieClip;
      
      private var gc:Config;
      
      private var _anti:Antiwear;
      
      private var renewalse:RenewalseThisSZ;
      
      public function ChineseNewYear2016(_today:String)
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         this._anti.today = _today;
         this._anti.seven = "7";
         this._anti.eight = "8";
         this._anti.night = "9";
         this._anti.ten = "10";
         this._anti.eleven = "11";
         this._anti.twelve = "12";
         this._anti.thirteen = "13";
         this._anti.fourteen = "14";
         this._anti.needtopay = 150;
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         var tary:* = null;
         var tlen:* = 0;
         this.removeEventListener("addedToStage",added);
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         backbtn.addEventListener("click",back);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         try
         {
            bigRedPack.addEventListener("click",readPackClick);
            retroactiveBtn.addEventListener("click",retroactiveClick);
            tary = gc.dataObject.newyear_2016_mark.split("-");
            tlen = uint(tary.length);
            if(tlen > 0)
            {
               while(tlen-- > 0)
               {
                  if(tary[tlen] != "" && tary[tlen] != "end")
                  {
                     this["b" + tary[tlen]].gotoAndStop(3);
                  }
               }
            }
            if(tary.lastIndexOf(this._anti.today) != -1)
            {
               this["b" + this._anti.today].gotoAndStop(3);
            }
            else
            {
               this["b" + this._anti.today].buttonMode = true;
               this["b" + this._anti.today].addEventListener("click",lanternClick);
               this["b" + this._anti.today].addEventListener("rollOver",mOver);
               this["b" + this._anti.today].addEventListener("rollOut",mOut);
            }
         }
         catch(e:*)
         {
         }
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         renewalse = null;
         backbtn.removeEventListener("click",back);
         bigRedPack.removeEventListener("click",readPackClick);
         retroactiveBtn.removeEventListener("click",retroactiveClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         renewalse = null;
         try
         {
            if(this["b" + this._anti.today])
            {
               this["b" + this._anti.today].removeEventListener("click",lanternClick);
               this["b" + this._anti.today].removeEventListener("rollOver",mOver);
               this["b" + this._anti.today].removeEventListener("rollOut",mOut);
            }
         }
         catch(e:*)
         {
         }
      }
      
      private function lanternClick(e:MouseEvent) : void
      {
         gc.signAgainDay(this._anti.today);
         this.getLanternFun();
         e.currentTarget.gotoAndStop(3);
         e.currentTarget.removeEventListener("click",lanternClick);
         e.currentTarget.removeEventListener("rollOver",mOver);
         e.currentTarget.removeEventListener("rollOut",mOut);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function getLanternFun(day:String = "", isBuqian:Boolean = false) : void
      {
         day = day;
         isBuqian = isBuqian;
         if(day == "")
         {
            var day:String = this._anti.today;
         }
         var reward:String = this.findAwardByData(day);
         if(reward != "")
         {
            var equip:MyEquipObj = gc.allEquip.findByName(reward);
            if(gc.player1.roleid > 0)
            {
               if(equip)
               {
                  gc.putQhsInBackPack(gc.player1,equip.getFillName());
               }
               gc.putQhsInBackPack(gc.player1,"xnhdl");
            }
            if(gc.player2.roleid > 0)
            {
               if(equip)
               {
                  gc.putQhsInBackPack(gc.player2,reward);
               }
               gc.putQhsInBackPack(gc.player1,"xnhdl");
            }
            setTimeout(function():*
            {
               if(isBuqian)
               {
                  gc.ts.setTxt("补签成功,获得 新年红灯笼x1、" + equip.ename + "x1");
               }
               else
               {
                  gc.ts.setTxt("恭喜获得 新年红灯笼x1、" + equip.ename + "x1");
               }
               gc.stage.addChild(gc.ts);
            },100);
         }
      }
      
      private function readPackClick(e:MouseEvent) : void
      {
         var str:* = null;
         str = null;
         var i:* = 0;
         var tary:Array = gc.dataObject.newyear_2016_mark.split("-");
         if(tary.indexOf("end") != -1)
         {
            gc.ts.setTxt("您已经领取过大红包");
            gc.stage.addChild(gc.ts);
            return;
         }
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
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
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
            return;
         }
         for(i = uint(7); i <= 14; )
         {
            if(tary.indexOf(i + "") == -1)
            {
               gc.ts.setTxt("没有点亮所有灯笼，无法领取大红包");
               gc.stage.addChild(gc.ts);
               return;
            }
            i++;
         }
         gc.dataObject.newyear_2016_mark += "end";
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getroomhorsePet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getroomhorsePet());
         }
         gc.ts.setTxt("大红包领取成功,获得 烈焰金刚");
         gc.stage.addChild(gc.ts);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function getroomhorsePet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("monkey1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1140);
         pif.setmpQuality(1140);
         pif.setatkQuality(1140);
         pif.setdefQuality(620);
         pif.setHp(200);
         pif.setMp(150);
         pif.setAtk(20);
         pif.setDef(6);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         pif.setCurExper(2524165);
         pif.theFourShape();
         return pif;
      }
      
      private function retroactiveClick(e:MouseEvent) : void
      {
         if(gc.getNoSignDay() != "")
         {
            this.addRenewalseMask("确定花费150点券补签吗?");
         }
         else
         {
            gc.ts.setTxt("您没有需要补签的日期");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function mOver(e:MouseEvent) : void
      {
         e.currentTarget.gotoAndStop(2);
      }
      
      private function mOut(e:MouseEvent) : void
      {
         e.currentTarget.gotoAndStop(1);
      }
      
      private function findAwardByData(day:String) : String
      {
         switch(day)
         {
            case this._anti.seven:
               return "wpqhs2";
            case this._anti.eight:
               return "mpyj";
            case this._anti.night:
               return "fys3";
            case this._anti.ten:
               return "mfs3";
            case this._anti.eleven:
               return "sms3";
            case this._anti.twelve:
               return "gjs3";
            case this._anti.thirteen:
               return "wpqhs3";
            case this._anti.fourteen:
               return "sbjyd";
            default:
               return "";
         }
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
         if(gc.gameVip.dataObject.lastMoney < this._anti.needtopay)
         {
            gc.ts.setTxt("账户余额不足");
            gc.stage.addChild(gc.ts);
            enough = false;
         }
         gc.pay.money = this._anti.needtopay;
         if(enough)
         {
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(8,"道具8",gc.pay.money,1);
               gc.lastPaymentString = "ChineseNewYear2016";
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
         if(gc.lastPaymentString != "ChineseNewYear2016")
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
         var nostr:String = gc.getNoSignDay();
         this.getLanternFun(nostr,true);
         if(this["b" + nostr])
         {
            this["b" + nostr].gotoAndStop(3);
         }
         gc.signAgainDay(gc.getNoSignDay());
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
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
      
      private function back(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

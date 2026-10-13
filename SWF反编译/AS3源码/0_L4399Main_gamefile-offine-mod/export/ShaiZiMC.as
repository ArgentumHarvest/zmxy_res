package export
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import my.MyEquipObj;
   import user.User;
   
   public class ShaiZiMC extends Sprite
   {
       
      
      private var shaiziArray:Array;
      
      private var keyPointArray:Array;
      
      private var stopPointArray:Array;
      
      private var stopPointArray2:Array;
      
      public var startBtn:SimpleButton;
      
      public var backBtn:SimpleButton;
      
      public var gofightbtn:SimpleButton;
      
      public var throwTimesTf:TextField;
      
      public var currentMosTf:TextField;
      
      private var renewalse:RenewalseThisSZ;
      
      private var isDebug:Boolean = false;
      
      private var _anti:Antiwear;
      
      private var gc:Config;
      
      private var isStarting:Boolean = false;
      
      public function ShaiZiMC()
      {
         shaiziArray = [];
         keyPointArray = [];
         stopPointArray = [];
         stopPointArray2 = [];
         _anti = new Antiwear(new binaryEncrypt());
         gc = Config.getInstance();
         super();
         startBtn.addEventListener("click",__startDrag);
         backBtn.addEventListener("click",__doBack);
         gofightbtn.addEventListener("click",__goToFight);
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         this.addEventListener("enterFrame",step);
         this._anti.dao = 0;
         this._anti.qiang = 0;
         this._anti.gong = 0;
         this._anti.fu = 0;
         this.refreshTextFieldDisplay();
      }
      
      protected function __goToFight(event:MouseEvent) : void
      {
         if(this._anti.dao == 0 && this._anti.qiang == 0 && this._anti.gong == 0)
         {
            gc.ts.setTxt("没有天兵,无法应战");
            gc.stage.addChild(gc.ts);
            return;
         }
         MainGame.getInstance().destroyGame();
         this.destroy();
         gc.stage541Type = 2;
         gc.stage541Args = [this._anti.dao,this._anti.qiang,this._anti.gong,this._anti.fu];
         gc.curStageAndCurLevel.curStage = 54;
         gc.curStageAndCurLevel.curLevel = 1;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
      }
      
      private function refreshTextFieldDisplay() : void
      {
         throwTimesTf.text = this.getThrowTimes() + "";
         currentMosTf.htmlText = "<font>天兵:" + (this._anti.dao + this._anti.qiang + this._anti.gong) + "</font>    " + "<font color=\'#ff0000\'>" + "福:" + this._anti.fu + "</font>";
      }
      
      public function step(evt:Event) : void
      {
         var isOver:Boolean = true;
         if(this.shaiziArray.length > 0)
         {
            for each(var mc in this.shaiziArray)
            {
               mc.step();
               if(!mc.isOver)
               {
                  isOver = false;
               }
            }
         }
         else
         {
            isOver = false;
         }
         if(isOver && this.isStarting)
         {
            this.showResult();
            startBtn.visible = true;
            this.isStarting = false;
         }
      }
      
      private function showResult() : void
      {
         var result:Array = this.getResult();
         trace("result:" + result);
         for each(var tv in result)
         {
            if(tv == 1)
            {
               this._anti.fu++;
               this._anti.dao++;
            }
            else if(tv == 2)
            {
               this._anti.dao++;
            }
            else if(tv == 3)
            {
               this._anti.qiang++;
            }
            else if(tv == 4)
            {
               this._anti.gong++;
            }
         }
         this.refreshTextFieldDisplay();
      }
      
      private function __doBack(evt:MouseEvent) : void
      {
         this.addRenewalseMask("退出之后你目前投掷的骰子所获得的天兵和福都将清零，确定要退出吗？");
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
         this.destroy();
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
      
      private function __confirm(evt:Event) : void
      {
         for each(var sz in this.shaiziArray)
         {
            if(this.contains(sz))
            {
               this.removeChild(sz);
            }
         }
         this.shaiziArray.length = 0;
         this.refreshTextFieldDisplay();
      }
      
      private function getThrowTimes() : int
      {
         var u:* = null;
         var shaizi:* = null;
         var shaiziNum:int = 0;
         for each(u in gc.getUsersArray())
         {
            shaizi = u.getSomeEquipInPackBackByName("sz");
            if(shaizi)
            {
               shaiziNum += shaizi.getENum();
            }
         }
         return shaiziNum;
      }
      
      private function __startDrag(evt:MouseEvent) : void
      {
         var u:* = null;
         var shaizi:* = null;
         var point:* = null;
         var singleShaiZi:* = null;
         var i:* = 0;
         var shaiziNum:int = this.getThrowTimes();
         if(shaiziNum <= 0)
         {
            gc.ts.setTxt("骰子数目不够");
            gc.stage.addChild(gc.ts);
            return;
         }
         this.isStarting = true;
         for each(u in gc.getUsersArray())
         {
            shaizi = u.getSomeEquipInPackBackByName("sz");
            if(shaizi && shaizi.getENum() > 0)
            {
               u.removeSomeEquip("sz",1);
               break;
            }
         }
         this.refreshTextFieldDisplay();
         startBtn.visible = false;
         for each(var sz in this.shaiziArray)
         {
            if(this.contains(sz))
            {
               this.removeChild(sz);
            }
         }
         this.shaiziArray.length = 0;
         keyPointArray.length = 0;
         stopPointArray.length = 0;
         point = new Point(130,320);
         keyPointArray.push(point);
         point = new Point(130,210);
         keyPointArray.push(point);
         point = new Point(285,180);
         keyPointArray.push(point);
         point = new Point(285,350);
         keyPointArray.push(point);
         point = new Point(440,210);
         keyPointArray.push(point);
         point = new Point(440,320);
         keyPointArray.push(point);
         point = new Point(295,350);
         stopPointArray.push(point);
         point = new Point(335,290);
         stopPointArray.push(point);
         point = new Point(155,260);
         stopPointArray.push(point);
         point = new Point(290,240);
         stopPointArray.push(point);
         point = new Point(185,320);
         stopPointArray.push(point);
         point = new Point(375,340);
         stopPointArray.push(point);
         point = new Point(230,240);
         stopPointArray.push(point);
         point = new Point(380,250);
         stopPointArray.push(point);
         point = new Point(260,300);
         stopPointArray.push(point);
         var offsetPoint:Point = new Point(190,100);
         for each(var p in this.keyPointArray)
         {
            p.offset(offsetPoint.x,offsetPoint.y);
         }
         for each(p in this.stopPointArray)
         {
            p.offset(offsetPoint.x,offsetPoint.y);
         }
         stopPointArray2 = stopPointArray.concat();
         for(i = uint(0); i < 4; )
         {
            singleShaiZi = new SingleShaiZi();
            singleShaiZi.x = 300;
            singleShaiZi.y = 350;
            singleShaiZi.targetPointArray = this.keyPointArray;
            singleShaiZi.stopPoint = this.getRandomStopPoint();
            singleShaiZi.targetValue = Math.ceil(RandomControllor.getIns().getRandom() * 4);
            this.addChild(singleShaiZi);
            this.shaiziArray.push(singleShaiZi);
            i++;
         }
      }
      
      private function getRandomStopPoint() : Point
      {
         var randIdx:uint = RandomControllor.getIns().getRandom() * this.stopPointArray.length;
         var returnPoint:Point = this.stopPointArray[randIdx];
         this.stopPointArray.splice(randIdx,1);
         return returnPoint;
      }
      
      public function getResult() : Array
      {
         var returnArray:Array = [];
         for each(var sz in this.shaiziArray)
         {
            returnArray.push(sz.targetValue);
         }
         return returnArray;
      }
      
      public function destroy() : void
      {
         this.removeEventListener("enterFrame",step);
         backBtn.removeEventListener("click",__doBack);
         startBtn.removeEventListener("click",__startDrag);
         gofightbtn.removeEventListener("click",__goToFight);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

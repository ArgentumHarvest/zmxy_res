package export.rank
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.DebugArea;
   import my.DescribeClass;
   
   public class RankTopInterface extends Sprite
   {
       
      
      public var nextPage:SimpleButton;
      
      public var prePage:SimpleButton;
      
      public var pagetxt:TextField;
      
      public var reportBtn:SimpleButton;
      
      public var fightbtn:SimpleButton;
      
      public var ranktitlemc:MovieClip;
      
      public var xbtn:SimpleButton;
      
      private var btnState;
      
      private var lastBtn:String = "";
      
      private var gc:Config;
      
      private var allPage:uint = 1;
      
      private var curPage:uint = 1;
      
      private var inRankInter:HasInRank;
      
      private var noinRankInter:NotInRank;
      
      private var _anti:Antiwear;
      
      public function RankTopInterface()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.rankListId = RankConfig.RANK_1;
         this._anti.five = 5;
         this._anti.twenty = 20;
         this._anti.ten = 10;
         this._anti.whichrequest = 1;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         if(gc.playNum >= 2)
         {
            this._anti.rankListId = RankConfig.RANK_2;
            ranktitlemc.gotoAndStop(2);
         }
         else
         {
            this._anti.rankListId = RankConfig.RANK_1;
            ranktitlemc.gotoAndStop(1);
         }
         nextPage.addEventListener("click",nextPageClick);
         prePage.addEventListener("click",prePageClick);
         fightbtn.addEventListener("click",fightClick);
         xbtn.addEventListener("click",xClick);
         reportBtn.addEventListener("click",reportClick);
         gc.eventManger.addEventListener("RANKSUBMITSUCCESS",rankSubmitSuccess);
         gc.eventManger.addEventListener("RANKLISTINFOSUCCESS",getRankListInfoSuccess);
         gc.eventManger.addEventListener("SELFRANGELISTINFOSUCCESS",getSelfRangeListInfoSuccess);
         gc.eventManger.addEventListener("RANKLISTERROR",rankError);
         gc.eventManger.addEventListener("ASKOWNRANKNULL",ownRankNull);
         gc.eventManger.addEventListener("SUBMITFAIL_RANKHASLOCK",submitFail);
         fightbtn.dispatchEvent(new MouseEvent("click"));
      }
      
      private function removed(e:Event) : void
      {
         nextPage.removeEventListener("click",nextPageClick);
         prePage.removeEventListener("click",prePageClick);
         fightbtn.removeEventListener("click",fightClick);
         xbtn.removeEventListener("click",xClick);
         reportBtn.removeEventListener("click",reportClick);
         gc.eventManger.removeEventListener("RANKSUBMITSUCCESS",rankSubmitSuccess);
         gc.eventManger.removeEventListener("RANKLISTINFOSUCCESS",getRankListInfoSuccess);
         gc.eventManger.removeEventListener("SELFRANGELISTINFOSUCCESS",getSelfRangeListInfoSuccess);
         gc.eventManger.removeEventListener("RANKLISTERROR",rankError);
         gc.eventManger.removeEventListener("ASKOWNRANKNULL",ownRankNull);
         gc.eventManger.removeEventListener("SUBMITFAIL_RANKHASLOCK",submitFail);
         this.removeChanllengeList();
         this.removeTopList();
         btnState = null;
      }
      
      private function ownRankNull(e:CommonEvent) : void
      {
         var ispr:* = null;
         if(this.getChildByName("Rank_Directions"))
         {
            this.removeChild(this.getChildByName("Rank_Directions"));
         }
         if(gc.rankhaslimit)
         {
            this.submitFail(null);
         }
         else
         {
            trace("--ownRankNull--");
            ispr = new ApplyRank();
            ispr.name = "Rank_Directions";
            ispr.x = 468.95;
            ispr.y = 2;
            this.addChild(ispr);
            if(this.getChildIndex(ispr) > this.getChildIndex(this.xbtn))
            {
               this.swapChildren(ispr,this.xbtn);
            }
         }
      }
      
      private function submitFail(e:CommonEvent) : void
      {
         if(!this.noinRankInter)
         {
            this.noinRankInter = new NotInRank();
            this.noinRankInter.x = 486.95;
            this.noinRankInter.y = 113.75;
            this.addChild(this.noinRankInter);
            this.requestLastTenRankList();
            gc.rankHasPassOneMin = false;
         }
      }
      
      private function rankSubmitSuccess(evt:CommonEvent) : void
      {
         this.requestRankList();
      }
      
      private function rankError(e:CommonEvent) : void
      {
         if(this.getChildByName("RankErrorInterface"))
         {
            this.removeChild(this.getChildByName("RankErrorInterface"));
         }
         var rei:RankErrorInterface = new RankErrorInterface();
         rei.name = "RankErrorInterface";
         this.addChild(rei);
      }
      
      public function submitScore() : void
      {
         if(gc.getAverageLevel() < 30)
         {
            gc.ts.setTxt("等级不足30级,不能提交战斗力");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.ownRankUser)
         {
            if(gc.ownRankUser.getScore() - gc.ownRankUser.getGongXun() == RankPropertyCount.getFightingForceByPlayerNum(gc.getUsersArray()) && gc.dataObject.gongxun == gc.ownRankUser.getGongXun())
            {
               gc.ts.setTxt("战斗力和功勋都没变，无法提交");
               gc.stage.addChild(gc.ts);
            }
            else
            {
               RankPropertyCount.submitRankScore(gc);
            }
         }
         else if(!gc.rankhaslimit)
         {
            RankPropertyCount.submitRankScore(gc);
         }
         else
         {
            gc.ts.setTxt("排行榜已经上锁");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getRankListInfoSuccess(e:CommonEvent) : void
      {
         var ru:* = null;
         var dataAry:Array = e.data[0];
         if(this._anti.whichrequest == 2)
         {
            gc.rankList.length = 0;
            for each(var obj in dataAry)
            {
               ru = new RankUsers();
               ru.setRankObject(obj);
               gc.rankList.push(ru);
            }
            this.allPage = Math.ceil(gc.rankList.length / 10);
            this.setTopList();
            this.setShow();
            trace("getRankListInfoSuccess --gc.rankhaslimit ->" + gc.rankhaslimit);
            if(!gc.rankhaslimit)
            {
               this.requestOwnRankList();
            }
            else if(!this.noinRankInter)
            {
               this.noinRankInter = new NotInRank();
               this.noinRankInter.x = 486.95;
               this.noinRankInter.y = 113.75;
               this.addChild(this.noinRankInter);
               this.requestLastTenRankList();
            }
         }
         else
         {
            this.setRangeList(dataAry);
            this.setChanllengeList();
            this.setShow();
         }
      }
      
      private function getSelfRangeListInfoSuccess(e:CommonEvent) : void
      {
         var dataAry:Array = e.data[0];
         for each(var obj in dataAry)
         {
            DebugArea.getIns().traceOut("getSelfRangeListInfoSuccess-->dataAry：" + DescribeClass.getObjectString(dataAry));
         }
         this.setRangeList(dataAry);
         if(!this.inRankInter)
         {
            this.inRankInter = new HasInRank();
            this.inRankInter.x = 486.95;
            this.inRankInter.y = 113.75;
            this.addChild(this.inRankInter);
         }
         this.setChanllengeList();
         this.setShow();
         gc.rankHasPassOneMin = false;
      }
      
      private function setRangeList(dataAry:Array) : void
      {
         var ru:* = null;
         gc.rangeList.length = 0;
         var diff:uint = 5;
         for each(var obj in dataAry)
         {
            ru = new RankUsers();
            ru.setRankObject(obj);
            ru.setRankDiff(diff);
            diff--;
            if(obj.uId == gc.logInfo.uid && obj.index == gc.luanqibazaojiami.saveId)
            {
               trace("-----own-----");
               gc.ownRankUser = ru;
            }
            else
            {
               gc.rangeList.push(ru);
            }
         }
      }
      
      private function nextPageClick(e:MouseEvent) : void
      {
         if(this.curPage < this.allPage)
         {
            this.curPage++;
            this.setTopList();
            this.setShow();
         }
      }
      
      private function prePageClick(e:MouseEvent) : void
      {
         if(this.curPage > 1)
         {
            this.curPage--;
            this.setTopList();
            this.setShow();
         }
      }
      
      private function fightClick(e:MouseEvent) : void
      {
         if(gc.rankHasPassOneMin)
         {
            this.requestRankList();
         }
         else
         {
            if(gc.rankhaslimit)
            {
               if(!this.noinRankInter)
               {
                  this.noinRankInter = new NotInRank();
                  this.noinRankInter.x = 486.95;
                  this.noinRankInter.y = 113.75;
                  this.addChild(this.noinRankInter);
               }
            }
            else if(!this.inRankInter)
            {
               this.inRankInter = new HasInRank();
               this.inRankInter.x = 486.95;
               this.inRankInter.y = 113.75;
               this.addChild(this.inRankInter);
            }
            this.allPage = Math.ceil(gc.rankList.length / 10);
            this.setTopList();
            this.setChanllengeList();
            this.setShow();
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "fightbtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function requestRankList() : void
      {
         if(gc.isHideDebug)
         {
            gc.addActionMask("renewalse");
            this._anti.whichrequest = 2;
            GMain.serviceHold.getRankListsData(this._anti.rankListId,this._anti.twenty,1);
         }
      }
      
      private function requestOwnRankList() : void
      {
         if(gc.isHideDebug)
         {
            gc.addActionMask("renewalse");
            GMain.serviceHold.getRankListByOwn(this._anti.rankListId,gc.luanqibazaojiami.saveId,this._anti.five);
         }
      }
      
      private function requestLastTenRankList() : void
      {
         if(gc.isHideDebug)
         {
            gc.addActionMask("renewalse");
            this._anti.whichrequest = 1;
            GMain.serviceHold.getRankListsData(this._anti.rankListId,this._anti.ten,10000);
         }
      }
      
      private function setTopList() : void
      {
         var i:int = 0;
         var tsg:* = null;
      }
      
      private function removeTopList() : void
      {
         var i:int = 0;
      }
      
      private function tlClick(e:MouseEvent) : void
      {
         var sru:* = null;
         if(this.getChildByName("ShowRankUserShow"))
         {
            this.removeChild(this.getChildByName("ShowRankUserShow"));
         }
         var rus:RankUsers = e.currentTarget.getRankUsers();
         if(rus)
         {
            sru = new ShowRankUser(rus);
            sru.name = "ShowRankUserShow";
            this.addChild(sru);
         }
      }
      
      private function setChanllengeList() : void
      {
         var i:* = 0;
         var j:* = 0;
         var cpt:* = null;
         this.removeChanllengeList();
         var k:uint = 0;
         for(i = uint(0); i < 2; )
         {
            for(j = uint(0); j < 5; )
            {
               if(gc.rangeList[k] != undefined)
               {
                  cpt = new ChanllengePlayerTop(gc.rangeList[k]);
                  cpt.name = "chanllengeplayerlist" + i + "" + j;
                  cpt.x = 495.95 + j * 84;
                  cpt.y = 288 + i * 120;
                  this.addChild(cpt);
                  k++;
               }
               j++;
            }
            i++;
         }
      }
      
      private function removeChanllengeList() : void
      {
         var i:* = 0;
         var j:* = 0;
         if(this.getChildByName("Rank_Directions"))
         {
            this.removeChild(this.getChildByName("Rank_Directions"));
         }
         for(i = uint(0); i < 2; )
         {
            for(j = uint(0); j < 5; )
            {
               if(this.getChildByName("chanllengeplayerlist" + i + "" + j))
               {
                  this.removeChild(this.getChildByName("chanllengeplayerlist" + i + "" + j));
               }
               j++;
            }
            i++;
         }
      }
      
      private function setShow() : void
      {
         if(this.inRankInter)
         {
            this.inRankInter.setShow();
         }
         if(this.noinRankInter)
         {
            this.noinRankInter.setShow();
         }
         this.pagetxt.text = this.curPage + "/" + this.allPage;
      }
      
      public function doWhenGotoChanllenge() : void
      {
         this.xClick(null);
      }
      
      private function reportClick(e:MouseEvent) : void
      {
         gc.openUrl("https://app.my.4399.com/r.php?app=feedback-report");
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

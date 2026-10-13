package export.rank
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MainGame;
   
   public class ChanllengePlayerTop extends Sprite
   {
       
      
      public var nametxt:TextField;
      
      public var valuetxt:TextField;
      
      private var head:MovieClip;
      
      private var curFrame:uint;
      
      private var rankUser:RankUsers;
      
      private var gc:Config;
      
      public function ChanllengePlayerTop(_rankUser:RankUsers)
      {
         super();
         gc = Config.getInstance();
         this.buttonMode = true;
         this.rankUser = _rankUser;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.setShow();
         this.addEventListener("click",__gotoChanllenge);
      }
      
      private function removed(e:Event) : void
      {
         if(head != null)
         {
            head.removeEventListener("rollOut",hout);
            head.removeEventListener("rollOver",hover);
         }
         this.removeEventListener("click",__gotoChanllenge);
      }
      
      private function __gotoChanllenge(evt:MouseEvent) : void
      {
         if(gc.dataObject.challengeRankTimes > 0)
         {
            gc.rankUsers = this.rankUser;
            if(gc.ownRankUser)
            {
               trace("gc.rankUsers.getRankDiff():" + gc.rankUsers.getRankDiff());
               gc.rankUsers.setWinGongxun((gc.rankUsers.getRankDiff() + 6) * 5);
            }
            gc.dataObject.challengeRankTimes--;
            gc.curStageAndCurLevel.curStage = 42;
            gc.curStageAndCurLevel.curLevel = 1;
            if(this.parent is RankTopInterface)
            {
               (this.parent as RankTopInterface).doWhenGotoChanllenge();
            }
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         }
         else
         {
            gc.ts.setTxt("本周挑战次数已经用完");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function setHead(str:String) : void
      {
         if(head && this.contains(head))
         {
            head.removeEventListener("rollOver",hover);
            head.removeEventListener("rollOut",hout);
            this.removeChild(head);
            head = null;
         }
         try
         {
            head = AUtils.getNewObj("rank_top_head_" + str) as MovieClip;
            this.addChild(head);
            if(this.getChildIndex(head) > this.getChildIndex(this.nametxt))
            {
               this.swapChildren(head,this.nametxt);
            }
            head.addEventListener("rollOver",hover);
            head.addEventListener("rollOut",hout);
         }
         catch(e:*)
         {
         }
      }
      
      private function setShow() : void
      {
         var ary:* = null;
         var sid:* = null;
         if(this.rankUser)
         {
            ary = this.rankUser.getRankUserArray();
            sid = "";
            for each(var ru in ary)
            {
               sid += ru.getRoleId();
            }
            this.setHead(sid);
            this.valuetxt.text = this.rankUser.getScore() + "";
            this.nametxt.text = this.rankUser.getUserName();
         }
         else
         {
            this.valuetxt.text = "";
            this.nametxt.text = "";
         }
      }
      
      private function hover(e:MouseEvent) : void
      {
         if(head)
         {
            curFrame = head.currentFrame;
            head.gotoAndStop(2);
         }
      }
      
      private function hout(e:MouseEvent) : void
      {
         if(head)
         {
            head.gotoAndStop(curFrame);
         }
      }
   }
}

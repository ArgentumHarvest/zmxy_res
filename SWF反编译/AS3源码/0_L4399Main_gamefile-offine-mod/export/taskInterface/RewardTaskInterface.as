package export.taskInterface
{
   import config.Config;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import task.Task;
   
   public class RewardTaskInterface extends Sprite
   {
       
      
      private var gc:Config;
      
      private var currentTask:Task;
      
      public var rewMc:MovieClip;
      
      public var getMc:MovieClip;
      
      public var headMc:MovieClip;
      
      public var taskTxt:TextField;
      
      public var xbtn:SimpleButton;
      
      public function RewardTaskInterface()
      {
         super();
         gc = Config.getInstance();
         rewMc.buttonMode = true;
         getMc.buttonMode = true;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
         this.initRewardTask();
      }
      
      private function removed(e:Event) : void
      {
         getMc.removeEventListener("click",lqClick);
         rewMc.removeEventListener("click",jsClick);
         xbtn.removeEventListener("click",xClick);
      }
      
      private function initRewardTask() : void
      {
         var relen:* = 0;
         if(!gc.allTask)
         {
            return;
         }
         currentTask = null;
         for each(var tk in gc.allTask.getrewTask())
         {
            if(!tk.getHasGetAward())
            {
               currentTask = tk;
               taskTxt.text = tk.getrwdict() + "";
               trace("tk.getIsComplete() -->" + tk.getIsComplete());
            }
            continue;
            if(tk.getIsComplete())
            {
               headMc.gotoAndStop(tk.getrwname() + "_2");
               rewMc.gotoAndStop(2);
               getMc.gotoAndStop(1);
               getMc.addEventListener("click",lqClick);
            }
            else
            {
               headMc.gotoAndStop(tk.getrwname());
               getMc.gotoAndStop(2);
               if(tk.getIsaccept())
               {
                  rewMc.gotoAndStop(3);
               }
               else
               {
                  rewMc.gotoAndStop(1);
               }
               rewMc.addEventListener("click",jsClick);
            }
            break;
         }
         if(currentTask == null)
         {
            relen = uint(gc.allTask.getrewTask().length);
            currentTask = gc.allTask.getrewTask()[relen - 1];
            headMc.gotoAndStop(currentTask.getrwname() + "_2");
            rewMc.gotoAndStop(2);
            getMc.gotoAndStop(2);
            taskTxt.text = currentTask.getrwdict() + "";
         }
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var ary:* = null;
         var eo:* = null;
         trace("领取任务的奖励类型 -->" + this.currentTask.rwaward[0].type);
         var showStr:String = "恭喜";
         if(this.currentTask)
         {
            switch(this.currentTask.rwaward[0].type)
            {
               case "level":
                  showStr += "您成功领取1点等级上限";
                  if(gc.dataObject.levelUpLimit < gc.dataObject.maxLevelUpLimit)
                  {
                     gc.dataObject.levelUpLimit++;
                  }
                  else
                  {
                     gc.dataObject.levelUpLimit = gc.dataObject.maxLevelUpLimit;
                  }
                  break;
               case "qhd":
                  if(gc.player1.roleid > 0)
                  {
                     gc.player1.dataObject.strenthtimes += 5;
                  }
                  if(gc.player2.roleid > 0)
                  {
                     gc.player2.dataObject.strenthtimes += 5;
                  }
                  showStr += "您成功领取5点强化点";
                  break;
               case "gmcs":
                  showStr += "您成功领取5次神秘商店购买机会";
                  gc.dataObject.mysteriousshoptimes += 5;
                  break;
               case "dj":
                  ary = String(this.currentTask.rwaward[0].value).split("-") as Array;
                  eo = gc.allEquip.findByName(ary[0]);
                  showStr += "您成功领取:" + eo.ename;
                  if(gc.player1.roleid > 0)
                  {
                     gc.putQhsInBackPack(gc.player1,ary[0],ary[1]);
                  }
                  if(gc.player2.roleid > 0)
                  {
                     gc.putQhsInBackPack(gc.player2,ary[0],ary[1]);
                  }
            }
            gc.ts.setTxt(showStr);
            gc.stage.addChild(gc.ts);
            this.currentTask.setHasGetAward(true);
            getMc.removeEventListener("click",lqClick);
            getMc.gotoAndStop(2);
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         this.initRewardTask();
      }
      
      private function jsClick(e:MouseEvent) : void
      {
         var stage:* = 0;
         var level:* = 0;
         var time:* = 0;
         if(currentTask)
         {
            if(rewMc.currentFrame == 1)
            {
               currentTask.setIsaccept(true);
               this.taskAwardAryById();
               rewMc.gotoAndStop(3);
               trace("接受任务随即到的奖励类型 -->" + this.currentTask.rwaward[0].type);
               if(currentTask.getrwId() == 500)
               {
                  stage = uint(1 + Math.round(RandomControllor.getIns().getRandom() * 2));
                  level = uint(1);
                  if(stage == 1)
                  {
                     level = uint(2 + Math.round(RandomControllor.getIns().getRandom()));
                  }
                  else
                  {
                     level = uint(1 + Math.round(RandomControllor.getIns().getRandom() * 2));
                  }
                  time = uint(1 + Math.round(RandomControllor.getIns().getRandom() * 299));
                  currentTask.setRandomAry([stage,level,time]);
               }
               else if(currentTask.getrwId() == 501)
               {
                  stage = uint(20 + Math.round(RandomControllor.getIns().getRandom() * 2));
                  if(stage == 20)
                  {
                     level = uint(1);
                  }
                  else
                  {
                     level = uint(1 + Math.round(RandomControllor.getIns().getRandom() * 2));
                  }
                  time = uint(1 + Math.round(RandomControllor.getIns().getRandom() * 299));
                  currentTask.setRandomAry([stage,level,time]);
               }
               else if(currentTask.getrwId() == 502)
               {
                  stage = uint(24 + Math.round(RandomControllor.getIns().getRandom()));
                  if(stage == 25)
                  {
                     level = uint(1 + Math.round(RandomControllor.getIns().getRandom()));
                  }
                  else
                  {
                     level = uint(1 + Math.round(RandomControllor.getIns().getRandom() * 2));
                  }
                  time = uint(1 + Math.round(RandomControllor.getIns().getRandom() * 299));
                  currentTask.setRandomAry([stage,level,time]);
               }
               else if(currentTask.getrwId() == 503)
               {
                  stage = uint(20 + Math.round(RandomControllor.getIns().getRandom() * 2));
                  if(stage == 20)
                  {
                     level = uint(1);
                  }
                  else
                  {
                     level = uint(1 + Math.round(RandomControllor.getIns().getRandom() * 2));
                  }
                  time = uint(1 + Math.round(RandomControllor.getIns().getRandom() * 299));
                  currentTask.setRandomAry([stage,level,time]);
               }
               gc.ts.setTxt("任务接受成功");
               gc.stage.addChild(gc.ts);
            }
            else if(rewMc.currentFrame == 3)
            {
               currentTask.setRandomAry([]);
               this.currentTask.rwaward = [];
               currentTask.setIsaccept(false);
               rewMc.gotoAndStop(1);
               gc.ts.setTxt("任务取消成功");
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      private function taskAwardAryById() : void
      {
         var newObj:* = null;
         var alen:uint = this.currentTask.getAllAward().length;
         var r:uint = Math.round(RandomControllor.getIns().getRandom() * (alen - 1));
         if(this.currentTask.getAllAward()[r])
         {
            newObj = {};
            newObj.type = this.currentTask.getAllAward()[r].type;
            if(this.currentTask.getAllAward()[r].type == "bs")
            {
               newObj.value = this.randomTaskAwardGem(this.currentTask.getAllAward()[r].value);
            }
            else if(this.currentTask.getAllAward()[r].type == "level")
            {
               if(gc.dataObject.levelUpLimit >= gc.dataObject.maxLevelUpLimit)
               {
                  this.taskAwardAryById();
                  return;
               }
               newObj.value = this.currentTask.getAllAward()[r].value;
            }
            else
            {
               newObj.value = this.currentTask.getAllAward()[r].value;
            }
            newObj.cname = this.currentTask.getAllAward()[r].cname;
            this.currentTask.rwaward.push(newObj);
         }
      }
      
      private function randomTaskAwardGem(n:String) : String
      {
         var i:* = 0;
         var s:* = null;
         var qhs:String = "wpqhs";
         var sms:String = "sms";
         var mfs:String = "mfs";
         var gjs:String = "gjs";
         var fys:String = "fys";
         var temp:Array = [];
         for(i = uint(0); i < n.length; )
         {
            s = n.substr(i,1);
            temp.push(qhs + s);
            temp.push(sms + s);
            temp.push(mfs + s);
            temp.push(gjs + s);
            temp.push(fys + s);
            i++;
         }
         var tlen:uint = temp.length;
         var r:uint = Math.round(RandomControllor.getIns().getRandom()) * (tlen - 1);
         return temp[r];
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

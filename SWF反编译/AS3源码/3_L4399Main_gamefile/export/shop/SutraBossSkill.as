package export.shop
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import user.User;
   
   public class SutraBossSkill extends Sprite
   {
       
      
      private var gc:Config;
      
      private var player:User;
      
      private var allBossSkillList:Array;
      
      private var currentPage:uint = 1;
      
      private var allPage:uint = 1;
      
      public var prebtn:SimpleButton;
      
      public var nextbtn:SimpleButton;
      
      public var setbtn:SimpleButton;
      
      public var sknametxt:TextField;
      
      public var sintratxt:TextField;
      
      public var SSJmc:MovieClip;
      
      public var WWJmc:MovieClip;
      
      public var SWJmc:MovieClip;
      
      private var highlight:MovieClip;
      
      private var currSelected:Object;
      
      public function SutraBossSkill(_player:User)
      {
         allBossSkillList = ["bs_qlj","bs_nh","bs_xz","bs_sfjz","bs_hlcj","bs_tl","bs_jt","bs_lx","bs_syfy","bs_erishiba_1","bs_erishiba_2","bs_erishiba_3","bs_erishiba_4","bs_erishiba_5","bs_erishiba_6","bs_erishiba_7","bs_erishiba_8","bs_erishiba_9","bs_erishiba_10","bs_erishiba_11","bs_erishiba_12","bs_erishiba_13","bs_erishiba_14"];
         currSelected = {};
         super();
         gc = Config.getInstance();
         this.player = _player;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.allPage = this.allBossSkillList.length % 20 + 1;
         highlight = AUtils.getNewObj("highlight");
         this.setBossSkillMC();
         this.setCurrentSkillShow();
         prebtn.addEventListener("click",prePageHandler);
         nextbtn.addEventListener("click",nextPageHandler);
         gc.eventManger.addEventListener("CLOSESKILLSETCONTROL",skillSetClose);
      }
      
      private function removed(e:Event) : void
      {
         prebtn.removeEventListener("click",prePageHandler);
         nextbtn.removeEventListener("click",nextPageHandler);
         setbtn.removeEventListener("click",setClick);
         this.removeBossSkillMC();
         gc.eventManger.removeEventListener("CLOSESKILLSETCONTROL",skillSetClose);
      }
      
      private function removeBossSkillMC() : void
      {
         var i:* = 0;
         var mc:* = null;
         var blen:uint = this.allBossSkillList.length;
         for(i = uint(0); i < blen; )
         {
            mc = this.getChildByName("grid" + i) as MovieClip;
            if(mc != null)
            {
               mc.removeEventListener("click",gridClick);
               if(this.contains(mc))
               {
                  this.removeChild(mc);
               }
               mc = null;
            }
            i++;
         }
      }
      
      private function setBossSkillMC() : void
      {
         var grid:* = null;
         var i:* = 0;
         var j:* = 0;
         if(this.highlight && contains(this.highlight))
         {
            this.removeChild(this.highlight);
         }
         this.removeBossSkillMC();
         var snum:uint = (this.currentPage - 1) * 20;
         for(i = uint(0); i < 2; )
         {
            for(j = uint(0); j < 10; )
            {
               if(this.allBossSkillList[snum] != undefined && this.allBossSkillList[snum] != null)
               {
                  grid = AUtils.getNewObj(this.allBossSkillList[snum]) as MovieClip;
                  grid.buttonMode = true;
                  grid.addEventListener("click",gridClick);
                  if(this.hasStudyThisBossSkill(this.allBossSkillList[snum]))
                  {
                     grid.gotoAndStop(2);
                  }
                  else
                  {
                     grid.gotoAndStop(1);
                  }
               }
               else
               {
                  grid = AUtils.getNewObj("emptytile");
               }
               grid.name = "grid" + snum;
               grid.x = 127.3 + j * (grid.width + 6);
               grid.y = 119.85 + i * (grid.height + 8);
               this.addChild(grid);
               if(snum == 0 || snum == 20)
               {
                  grid.dispatchEvent(new MouseEvent("click"));
               }
               snum++;
               j++;
            }
            i++;
         }
         this.addChild(highlight);
      }
      
      private function skillSetClose(e:CommonEvent) : void
      {
         this.setCurrentSkillShow();
      }
      
      private function setCurrentSkillShow() : void
      {
         var img:* = null;
         var sprite:* = null;
         var smallShow:* = null;
         if(this.player == null)
         {
            return;
         }
         this.removeCurrentShowMc();
         if(this.player.getControlPlayer() == 0)
         {
            this.SSJmc.gotoAndStop(1);
            this.WWJmc.gotoAndStop(1);
            this.SWJmc.gotoAndStop(1);
         }
         else
         {
            this.SSJmc.gotoAndStop(2);
            this.WWJmc.gotoAndStop(2);
            this.SWJmc.gotoAndStop(2);
         }
         var slen:uint = this.player.bossskillbykey.length;
         for(var keys:String = ""; slen-- > 0; )
         {
            img = AUtils.getNewObj(this.player.bossskillbykey[slen].skillName);
            img.gotoAndStop(2);
            sprite = new Sprite();
            sprite.name = "cursprite" + this.player.bossskillbykey[slen].keys;
            sprite.addChild(img);
            if(this.player.controlPlayer == 0)
            {
               keys = this.player.bossskillbykey[slen].keys;
            }
            else
            {
               keys = this.player.bossskillbykey[slen].keys;
               if(keys == "↓↓1")
               {
                  keys = "SSJ";
               }
               else if(keys == "↑↑1")
               {
                  keys = "WWJ";
               }
               else if(keys == "↓↑1")
               {
                  keys = "SWJ";
               }
            }
            sprite.x = this[keys + "mc"].x + 5;
            sprite.y = this[keys + "mc"].y + 5;
            this.addChild(sprite);
            smallShow = new Sprite();
            smallShow.addChild(AUtils.getImageObj("BossSkill_" + this.player.bossskillbykey[slen].keys));
            smallShow.x = sprite.width / 3;
            smallShow.y = sprite.height / 2;
            sprite.addChild(smallShow);
         }
      }
      
      private function removeCurrentShowMc() : void
      {
         var btnAry:Array = [];
         if(this.player.controlPlayer == 0)
         {
            btnAry = ["SSJ","WWJ","SWJ"];
         }
         else
         {
            btnAry = ["↓↓1","↑↑1","↓↑1"];
         }
         for(var blen:uint = btnAry.length; blen-- > 0; )
         {
            if(this.getChildByName("cursprite" + btnAry[blen]) != null)
            {
               this.removeChild(this.getChildByName("cursprite" + btnAry[blen]));
            }
         }
      }
      
      private function hasStudyThisBossSkill(sname:String) : Boolean
      {
         var sit:int = 0;
         if(this.player)
         {
            sit = this.player.hasstudybossskill.indexOf(sname);
            if(sit != -1)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      private function singleIntroduce(islistener:uint) : void
      {
         this.sknametxt.text = "";
         this.sintratxt.text = "";
         if(this.getChildByName("icon") != null)
         {
            this.removeChild(this.getChildByName("icon"));
         }
         if(islistener == 1)
         {
            setbtn.removeEventListener("click",setClick);
         }
         else if(!setbtn.hasEventListener("click"))
         {
            setbtn.addEventListener("click",setClick);
         }
         this.sknametxt.text = this.currSelected.cname;
         this.sintratxt.text = this.currSelected.intro;
         var icon:MovieClip = AUtils.getNewObj(this.currSelected.sname);
         if(this.hasStudyThisBossSkill(this.currSelected.sname))
         {
            icon.gotoAndStop(2);
         }
         else
         {
            icon.gotoAndStop(1);
         }
         icon.name = "icon";
         icon.x = 239.3;
         icon.y = 347.8;
         this.addChild(icon);
      }
      
      private function setClick(e:MouseEvent) : void
      {
         trace("--setClick--");
         var bssc:BossSkillSetControl = this.getChildByName("BossSkillSetControl") as BossSkillSetControl;
         if(bssc)
         {
            this.removeChild(bssc);
         }
         bssc = null;
         var curbssc:BossSkillSetControl = new BossSkillSetControl(this.player,this.currSelected.sname,this.player.findBossSkillNeedMp(this.currSelected.sname));
         this.addChild(curbssc);
      }
      
      private function gridClick(e:MouseEvent) : void
      {
         var index:int = int(String(e.currentTarget.name).substr(4));
         this.highlight.x = e.currentTarget.x;
         this.highlight.y = e.currentTarget.y;
         trace("index-->>" + index);
         this.transChineseName(this.allBossSkillList[index]);
         this.singleIntroduce(e.currentTarget.currentFrame);
      }
      
      private function prePageHandler(e:MouseEvent) : void
      {
         if(this.currentPage > 1)
         {
            this.currentPage--;
            this.setBossSkillMC();
         }
      }
      
      private function nextPageHandler(e:MouseEvent) : void
      {
         if(this.currentPage < this.allPage)
         {
            this.currentPage++;
            this.setBossSkillMC();
         }
      }
      
      private function transChineseName(sname:String) : void
      {
         if(this.currSelected == null)
         {
            return;
         }
         this.currSelected.sname = sname;
         var cname:String = "";
         var intro:String = "";
         switch(sname)
         {
            case "bs_qlj":
               cname = "强力箭";
               intro = "射出一支光箭击退前方怪物";
               break;
            case "bs_nh":
               cname = "怒吼";
               intro = "吸引怪物到自己周围";
               break;
            case "bs_xz":
               cname = "旋斩";
               intro = "快速旋转对周围怪物造成多次伤害";
               break;
            case "bs_sfjz":
               cname = "十方剑阵";
               intro = "召唤剑阵对周围怪物造成伤害，并有概率冰冻怪物";
               break;
            case "bs_hlcj":
               cname = "火龙出击";
               intro = "丢出火矛对前方怪物造成伤害，并附带灼烧效果";
               break;
            case "bs_tl":
               cname = "天雷";
               intro = "释放雷咒对周围怪物造成伤害";
               break;
            case "bs_jt":
               cname = "践踏";
               intro = "践踏地面，晕眩周围怪物";
               break;
            case "bs_lx":
               cname = "雷旋";
               intro = "快速旋转对前方怪物造成伤害";
               break;
            case "bs_syfy":
               cname = "三眼封印";
               intro = "对前方的怪物造成巨大的伤害";
               break;
            case "bs_erishiba_1":
               cname = "土遁术";
               intro = "掘地三尺，后破土而出";
               break;
            case "bs_erishiba_2":
               cname = "烈翼冲击";
               intro = "飞速向前，并喷射火焰";
               break;
            case "bs_erishiba_3":
               cname = "藤蔓缠绕";
               intro = "缠绕住前方怪物，使其不能移动，并持续扣血";
               break;
            case "bs_erishiba_4":
               cname = "火焰狂拳";
               intro = "飞舞狂拳，打出许多火焰弹，攻击前方怪物";
               break;
            case "bs_erishiba_5":
               cname = "飞沙走石";
               intro = "飞起碎石，攻击前方怪物";
               break;
            case "bs_erishiba_6":
               cname = "百鬼夜行";
               intro = "身上飞出许多鬼魂，绕着鬼金羊旋转并扩散，攻击触碰到的怪物";
               break;
            case "bs_erishiba_7":
               cname = "剧毒枯藤";
               intro = "从地下穿出枯藤攻击怪物，并附带毒效果";
               break;
            case "bs_erishiba_8":
               cname = "疯狂利爪";
               intro = "用爪子撕裂怪物";
               break;
            case "bs_erishiba_9":
               cname = "烈火战车";
               intro = "冲向怪物，所到之处喷出烈火";
               break;
            case "bs_erishiba_10":
               cname = "飞燕冲击";
               intro = "召唤一只燕子快速飞向怪物";
               break;
            case "bs_erishiba_11":
               cname = "疯狂撕咬";
               intro = "冲向怪物，快速撕咬";
               break;
            case "bs_erishiba_12":
               cname = "噩梦音波";
               intro = "对前方怪物造成连续三次伤害";
               break;
            case "bs_erishiba_13":
               cname = "怒火";
               intro = "随机喷射火柱对周围怪物造成伤害";
               break;
            case "bs_erishiba_14":
               cname = "冲击波";
               intro = "发出一道冲击波，对前方怪物造成伤害";
         }
         this.currSelected.cname = cname;
         this.currSelected.intro = intro;
      }
   }
}

package export.rank
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.my.Base64ForAs3;
   import config.Config;
   import flash.utils.ByteArray;
   import my.MyEquipObj;
   import user.User;
   
   public class RankPropertyCount
   {
       
      
      public function RankPropertyCount()
      {
         super();
      }
      
      public static function getInfoByPlayer(player:User) : String
      {
         var len:* = 0;
         var i:* = 0;
         var eq:* = null;
         var returnStr:String = "";
         returnStr += player.roleid + "|";
         returnStr += player.getCurLevel() + "|";
         len = uint(player.curarray.length);
         for(i = uint(0); i < len; )
         {
            eq = player.curarray[i] as MyEquipObj;
            returnStr += eq.getFillName();
            returnStr += "=";
            returnStr += eq.getStrengthValue();
            returnStr += "=";
            returnStr += eq.getehp(true);
            returnStr += "=";
            returnStr += eq.getemp(true);
            returnStr += "=";
            returnStr += eq.geteatt(true);
            returnStr += "=";
            returnStr += eq.getedef(true);
            returnStr += "=";
            returnStr += eq.getecrit(true);
            returnStr += "=";
            returnStr += eq.getemiss(true);
            returnStr += "=";
            returnStr += eq.geteahp(true);
            returnStr += "=";
            returnStr += eq.geteamp(true);
            returnStr += "=";
            returnStr += eq.getmagicdef(true);
            returnStr += "=";
            returnStr += eq.getELevel();
            returnStr += "=";
            returnStr += eq.getWXForRank();
            returnStr += "=";
            returnStr += eq.getEUpdata().toFixed(1);
            returnStr += "=";
            returnStr += eq.getMutiLevel();
            if(i < len - 1)
            {
               returnStr += "~";
            }
            i++;
         }
         returnStr += "|";
         if(player.roleid == 1)
         {
            returnStr += !!player.findSkillIsInTheSkillAry("sx") ? "1" : "0";
         }
         else
         {
            returnStr += "0";
         }
         returnStr += "|";
         player.checkPassiveSkillAndPill();
         returnStr += player.dataObject.ispassiveskill.join(",");
         returnStr += "|";
         var pillHp:int = player.findAllImmortalityAddHp();
         return returnStr + pillHp;
      }
      
      public static function submitRankScore(gc:Config) : void
      {
         var p:* = null;
         var p1:* = null;
         var p2:* = null;
         checkEquip(gc);
         var dataObj:Object = {};
         if(gc.playNum == 1)
         {
            p = gc.player1;
            dataObj.extra = gc.dataObject.challengeRankTimes + "^" + gc.dataObject.gongxun + "^" + RankPropertyCount.getInfoByPlayer(p);
            dataObj.rId = RankConfig.RANK_1;
            dataObj.score = getFightingForce(p) + gc.dataObject.gongxun;
            if(getFightingForce(p) > 10000 || gc.dataObject.gongxun > 1650)
            {
               gc.ts.setTxt("战斗力:" + getFightingForce(p) + "," + "功勋：" + gc.dataObject.gongxun + "，无法提交，请联系客服");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(isRankInfoLenToLong(dataObj.extra))
            {
               trace("数据异常，请联系客服");
               gc.ts.setTxt("数据异常，请联系客服");
               gc.stage.addChild(gc.ts);
               return;
            }
         }
         else
         {
            if(gc.playNum != 2)
            {
               gc.ts.setTxt("数据有误，无法提交");
               gc.stage.addChild(gc.ts);
               return;
            }
            p1 = gc.player1;
            p2 = gc.player2;
            dataObj.extra = gc.dataObject.challengeRankTimes + "^" + gc.dataObject.gongxun + "^" + getInfoByPlayer(p1) + "&" + getInfoByPlayer(p2);
            dataObj.rId = RankConfig.RANK_2;
            dataObj.score = getFightingForceByPlayerNum(gc.getUsersArray()) + gc.dataObject.gongxun;
            if(getFightingForceByPlayerNum(gc.getUsersArray()) > 10000 || gc.dataObject.gongxun > 1650)
            {
               gc.ts.setTxt("战斗力:" + getFightingForce(p) + "," + "功勋：" + gc.dataObject.gongxun + "，无法提交，请联系客服");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(isRankInfoLenToLong(dataObj.extra))
            {
               gc.ts.setTxt("数据异常，请联系客服");
               gc.stage.addChild(gc.ts);
               return;
            }
         }
         if(GMain.serviceHold)
         {
            GMain.serviceHold.submitScoreToRankLists(gc.luanqibazaojiami.saveId,[dataObj]);
         }
      }
      
      public static function checkEquip(gc:Config) : void
      {
         var eq:* = null;
         if(gc.player1.roleid > 0)
         {
            for each(eq in gc.player1.curarray)
            {
            }
         }
         if(gc.player2.roleid > 0)
         {
            for each(eq in gc.player2.curarray)
            {
            }
         }
      }
      
      public static function getFightingForceByPlayerNum(users:Array) : uint
      {
         var p1:* = null;
         var p2:* = null;
         if(users.length == 1)
         {
            p1 = users[0] as User;
            if(p1)
            {
               return getFightingForce(p1);
            }
         }
         else if(users.length == 2)
         {
            p1 = users[0] as User;
            p2 = users[1] as User;
            if(p1 && p2)
            {
               return (getFightingForce(p1) + getFightingForce(p2)) / 2;
            }
         }
         return 0;
      }
      
      public static function getFightingForce(player:User) : uint
      {
         var num:* = 0;
         var hpPassive:int = 0;
         var mpPassive:int = 0;
         var critPassive:int = 0;
         var selfhpPassive:int = 0;
         var selfmpPassive:int = 0;
         trace("getFightingForce");
         var score:uint = 0;
         var anti:Antiwear = new Antiwear(new binaryEncrypt());
         anti.shiwu = 15;
         anti.lingdianyi = 0.1;
         anti.shi = 10;
         anti.ba = 8;
         anti.shier = 12;
         anti.yibai = 100;
         anti.wu = 5;
         anti.ershi = 20;
         anti.ershier = 22;
         anti.ershiwu = 25;
         anti.sanshi = 30;
         anti.sishi = 40;
         score += player.getCurLevel() * anti.shiwu;
         trace("score-等级:" + score);
         score += player.findAllImmortalityAddHp() * anti.lingdianyi;
         var skillArray:Array = player.dataObject.ispassiveskill;
         var plen:uint = skillArray.length;
         while(plen-- > 0)
         {
            num = uint(skillArray[plen]);
            if(num == 0)
            {
               continue;
            }
            switch(int(plen))
            {
               case 0:
                  hpPassive = num * anti.yibai + anti.yibai;
                  score += hpPassive * anti.lingdianyi;
                  break;
               case 1:
                  mpPassive = num * anti.yibai + anti.yibai;
                  score += mpPassive * anti.lingdianyi;
                  break;
               case 2:
                  critPassive = num * 1 + 1;
                  score += critPassive * anti.shi;
                  break;
               case 3:
                  selfhpPassive = num + 1;
                  score += selfhpPassive * anti.shi;
                  break;
               case 4:
                  selfmpPassive = num + 1;
                  score += selfmpPassive * anti.shi;
                  break;
            }
         }
         trace("score-被动:" + score);
         var totalAtk:int = 0;
         var totalCrit:int = 0;
         var totalHx:uint = 0;
         var totalHl:uint = 0;
         var totalMdef:uint = 0;
         var totalMiss:uint = 0;
         for each(var eq in player.curarray)
         {
            totalAtk += eq.geteatt();
            totalCrit += eq.getecrit() * 100;
            totalHx += eq.geteahp();
            totalHl += eq.geteamp();
            totalMdef += eq.getmagicdef() * 100;
            totalMiss += eq.getemiss() * 100;
         }
         score += totalAtk;
         trace("score-装备攻击:" + score);
         if(player.roleid == 1)
         {
            if(player.findSkillIsInTheSkillAry("sx"))
            {
               score += (anti.wu + totalCrit) * anti.ershiwu;
            }
            else
            {
               score += totalCrit * anti.ershiwu;
            }
         }
         else if(player.roleid == 2)
         {
            score += totalHl * anti.sanshi;
            score += totalCrit * anti.sanshi;
         }
         else if(player.roleid == 3)
         {
            score += totalHx * anti.ba;
            score += totalMdef * anti.ba;
            score += totalCrit * anti.shi;
         }
         else if(player.roleid == 4)
         {
            score += totalCrit * anti.ershi;
            score += totalMiss * anti.ershi;
         }
         trace("score-特殊:" + score);
         return score;
      }
      
      public static function getFightingScoreByString(str:String, gc:Config) : int
      {
         var info:* = null;
         var playerUsersArray:* = null;
         var u:* = null;
         var infoArr:* = null;
         var equipString:* = null;
         var equipArray:* = null;
         var singleEquipArray:* = null;
         var eq:* = null;
         trace("getFightingScoreByString");
         var score:int = 0;
         var arr1:Array = str.split("^");
         if(arr1.length >= 3)
         {
            info = arr1[2];
            playerUsersArray = info.split("&");
            for each(var userInfo in playerUsersArray)
            {
               u = new User();
               infoArr = userInfo.split("|");
               if(infoArr.length >= 6)
               {
                  u.roleid = infoArr[0];
                  u.setCurLevel(infoArr[1]);
                  equipString = infoArr[2];
                  equipArray = equipString.split("~");
                  for each(var s in equipArray)
                  {
                     singleEquipArray = s.split("=");
                     trace("singleEquipArray:" + singleEquipArray);
                     trace("------------");
                     eq = gc.allEquip.findByName(singleEquipArray[0]) as MyEquipObj;
                     eq.setstrengthValue(singleEquipArray[1]);
                     eq.setehp(singleEquipArray[2]);
                     eq.setemp(singleEquipArray[3]);
                     eq.seteatt(singleEquipArray[4]);
                     eq.setedef(singleEquipArray[5]);
                     eq.setecrit(singleEquipArray[6]);
                     eq.setemiss(singleEquipArray[7]);
                     eq.seteahp(singleEquipArray[8]);
                     eq.seteamp(singleEquipArray[9]);
                     eq.setmagicdef(singleEquipArray[10]);
                     eq.setELevel(singleEquipArray[11]);
                     eq.setWXFromRank(singleEquipArray[12]);
                     eq.setEupdata(singleEquipArray[13]);
                     eq.strengthenEquip();
                     u.curarray.push(eq);
                  }
                  u.dataObject.ispassiveskill = (infoArr[4] as String).split(",");
                  score += int(infoArr[5]) / 10;
                  trace("score----丹药：" + score);
                  score += getFightingForce(u);
                  trace("score----user:" + score);
                  if(u.roleid == 1)
                  {
                     if(int(infoArr[3]) == 1)
                     {
                        score += 120;
                     }
                  }
                  trace("score----嗜血:" + score);
               }
            }
            score /= playerUsersArray.length;
            trace("score----平均分:" + score);
         }
         return score;
      }
      
      public static function isRankInfoLenToLong(extra:String) : Boolean
      {
         var byte:ByteArray = new ByteArray();
         byte.writeObject(extra);
         byte.compress();
         var comprassStr:String = Base64ForAs3.encodeByteArray(byte);
         byte = null;
         var tmpByte2:ByteArray = new ByteArray();
         tmpByte2.writeObject(comprassStr);
         var len:int = tmpByte2.length;
         tmpByte2 = null;
         if(len > 512)
         {
            return true;
         }
         return false;
      }
      
      public static function getFightingScoreDiffCoefficientByFightingScorediff(diff:int) : Number
      {
         if(diff < 150)
         {
            return 0.1;
         }
         if(diff < 300)
         {
            return 0.2;
         }
         if(diff < 450)
         {
            return 0.3;
         }
         if(diff < 600)
         {
            return 0.4;
         }
         if(diff < 750)
         {
            return 0.5;
         }
         if(diff < 1500)
         {
            return 1;
         }
         return 1.1;
      }
   }
}

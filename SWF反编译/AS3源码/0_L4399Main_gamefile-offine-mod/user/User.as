package user
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import loader.Aloader2;
   import mvc.controllor.RandomControllor;
   import my.FinancialInfo;
   import my.MyEquipObj;
   import my.PetEquipObj;
   import petInfo.PetInfo;
   
   public class User
   {
      
      public static var batterNum:int;
      
      public static var biggestbatterNum:int;
       
      
      var gc:Config;
      
      public var controlPlayer:int;
      
      private var lhValue1:int;
      
      private var lhValue2:int;
      
      private var myscore1:uint;
      
      private var myscore2:uint;
      
      private var curLevel1:uint;
      
      private var curLevel2:uint;
      
      private var curExp1:int;
      
      private var curExp2:int;
      
      private var skillLimit1:int;
      
      private var skillLimit2:int;
      
      private var luckdata1:int;
      
      private var luckdata2:int;
      
      public var roleid:uint = 0;
      
      public var tarray:Array;
      
      public var zblist:Array;
      
      public var djlist:Array;
      
      public var szlist:Array;
      
      public var jnslist:Array;
      
      public var plist:Array;
      
      public var outlist:Array;
      
      public var curarray:Array;
      
      public var isstudyskill:Array;
      
      public var skillbykey:Array;
      
      public var immortalitylist:Array;
      
      public var hasstudybossskill:Array;
      
      public var bossskillbykey:Array;
      
      public var saveObj:Object;
      
      private var issaveing:Boolean = false;
      
      private var savelist:Array;
      
      public var updatalist:Array;
      
      public var exAry:Array;
      
      private var lastsavelen:uint = 0;
      
      public var petsAry:Array;
      
      private var curEquipType:Array;
      
      public var dataObject:Antiwear;
      
      public var isshowfashion:Boolean = true;
      
      public var isRealiveByBagua:Boolean = false;
      
      public var index:int = 0;
      
      public function User()
      {
         tarray = [];
         zblist = [];
         djlist = [];
         szlist = [];
         jnslist = [];
         plist = [];
         outlist = [];
         curarray = [];
         isstudyskill = [{
            "xflevel":0,
            "skillName":""
         },{
            "xflevel":0,
            "skillName":""
         }];
         skillbykey = [];
         immortalitylist = [{
            "usenum":0,
            "canuse":true
         },{
            "usenum":0,
            "canuse":true
         },{
            "usenum":0,
            "canuse":true
         },{
            "usenum":0,
            "canuse":true
         },{
            "usenum":0,
            "canuse":true
         }];
         hasstudybossskill = [];
         bossskillbykey = [];
         saveObj = {};
         savelist = [];
         updatalist = [];
         exAry = [0,0,0,0];
         petsAry = [];
         super();
         gc = Config.getInstance();
         this.dataObject = new Antiwear(new binaryEncrypt());
         this.setCurLevel(1);
         this.setCurExp(0);
         this.setSkillLimit(5);
         this.setTadayLuckValue();
         this.dataObject.ispassiveskill = [0,0,0,0,0];
      }
      
      public function init(cp:uint) : *
      {
         this.controlPlayer = cp;
         this.dataObject.biggestpassiveskilllevel = 5;
         this.dataObject.strenthtimes = 5;
         this.setExAry(gc.luanqibazaojiami.saveId,this.roleid);
      }
      
      public function getMax() : int
      {
         if(this.getCurLevel() >= 50)
         {
            return 75;
         }
         return 50;
      }
      
      public function getControlPlayer() : int
      {
         return controlPlayer;
      }
      
      public function getEquipNum() : Object
      {
         var myObj:* = null;
         var curList:Object = {
            "zbfj":0,
            "zbwq":0,
            "zbtx":""
         };
         var fashionId:uint = 0;
         var fjId:uint = 0;
         for(var clen:uint = this.curarray.length; clen-- > 0; )
         {
            myObj = curarray[clen];
            if(curarray[clen].type == "zbfj")
            {
               fjId = myObj.showid;
            }
            if(curarray[clen].type == "zbsz")
            {
               fashionId = myObj.showid;
            }
            if(curarray[clen].type == "zbwq")
            {
               curList.zbwq = myObj.showid;
            }
            if(curarray[clen].type == "zbtx")
            {
               curList.zbtx = myObj.getFillName();
            }
         }
         if(this.isshowfashion == true || this.isshowfashion == "true")
         {
            curList.zbfj = fashionId > 0 ? fashionId : fjId;
         }
         else
         {
            curList.zbfj = fjId;
         }
         return curList;
      }
      
      public function getSomeEquipNameInCurrentEquip(type:String) : String
      {
         for each(var equip in curarray)
         {
            if(equip.type == type)
            {
               return equip.getFillName();
            }
         }
         return "";
      }
      
      public function setLhValue(v:int) : void
      {
         this.lhValue1 = AUtils.getRandomValue();
         this.lhValue2 = v - this.lhValue1;
         if(this.getLhValue() < 0)
         {
            this.setLhValue(0);
         }
      }
      
      public function getLhValue() : int
      {
         return lhValue1 + lhValue2;
      }
      
      public function setMyScore(v:uint) : void
      {
         this.myscore1 = AUtils.getRandomValue();
         this.myscore2 = v - this.myscore1;
      }
      
      public function getMyScore() : uint
      {
         return myscore1 + myscore2;
      }
      
      public function setCurLevel(v:uint) : void
      {
         this.curLevel1 = AUtils.getRandomValue();
         this.curLevel2 = v - this.curLevel1;
      }
      
      public function getCurLevel() : uint
      {
         return curLevel1 + curLevel2;
      }
      
      public function setCurExp(v:uint) : void
      {
         this.curExp1 = AUtils.getRandomValue();
         this.curExp2 = v - this.curExp1;
      }
      
      public function getCurExp() : uint
      {
         return curExp1 + curExp2;
      }
      
      public function setSkillLimit(v:uint) : void
      {
         this.skillLimit1 = AUtils.getRandomValue();
         this.skillLimit2 = v - this.skillLimit1;
      }
      
      public function getSkillLimt() : int
      {
         return this.skillLimit1 + this.skillLimit2;
      }
      
      public function setLuckData(v:int) : void
      {
         this.luckdata1 = AUtils.getRandomValue();
         this.luckdata2 = v - this.luckdata1;
      }
      
      public function getLuckData() : int
      {
         return this.luckdata1 + this.luckdata2;
      }
      
      public function getTotalLuckData() : int
      {
         var txName:String = this.getSomeEquipNameInCurrentEquip("zbtx");
         if(txName == "_zmxyanniversary" || txName == "_zmxyjlxnkl")
         {
            return this.getLuckData() + 10;
         }
         if(txName == "_zmxyptxnkl")
         {
            return this.getLuckData() + 2;
         }
         if(txName == "_zmxyyxxnkl")
         {
            return this.getLuckData() + 5;
         }
         if(txName == "_zmxyssxnkl")
         {
            return this.getLuckData() + 15;
         }
         if(txName == "_zmxyptxnkl2014" || txName == "_zmxyptxnkl2017")
         {
            return this.getLuckData() + 2;
         }
         if(txName == "_zmxyyxxnkl2014" || txName == "_zmxyyxxnkl2017")
         {
            return this.getLuckData() + 5;
         }
         if(txName == "_zmxyjlxnkl2014" || txName == "_zmxyjlxnkl2017")
         {
            return this.getLuckData() + 10;
         }
         if(txName == "_zmxyssxnkl2014" || txName == "_zmxyssxnkl2017")
         {
            return this.getLuckData() + 15;
         }
         if(txName == "_yxwsjkh")
         {
            return this.getLuckData() + 10;
         }
         if(txName == "_jlwsjkh")
         {
            return this.getLuckData() + 20;
         }
         if(txName == "_sswsjkh" || txName == "_zmszntx")
         {
            return this.getLuckData() + 30;
         }
         if(txName == "ptsrdg")
         {
            return this.getLuckData() + 6;
         }
         if(txName == "yxsrdg")
         {
            return this.getLuckData() + 9;
         }
         if(txName == "jlsrdg")
         {
            return this.getLuckData() + 12;
         }
         if(txName == "sssrdg")
         {
            return this.getLuckData() + 15;
         }
         if(txName == "sssrdg2")
         {
            return this.getLuckData() + 18;
         }
         return this.getLuckData();
      }
      
      public function getSomeEquipInPackBackByName(_name:String) : MyEquipObj
      {
         for(var dlen:uint = this.djlist.length; dlen-- > 0; )
         {
            if(this.djlist[dlen].getFillName() == _name)
            {
               return this.djlist[dlen];
            }
         }
         for(var zlen:uint = this.zblist.length; zlen-- > 0; )
         {
            if(this.zblist[zlen].getFillName() == _name)
            {
               return this.zblist[zlen];
            }
         }
         for(var slen:uint = this.szlist.length; slen-- > 0; )
         {
            if(this.szlist[slen].getFillName() == _name)
            {
               return this.szlist[slen];
            }
         }
         for(var jlen:uint = this.jnslist.length; jlen-- > 0; )
         {
            if(this.jnslist[jlen].getFillName() == _name)
            {
               return this.jnslist[jlen];
            }
         }
         return null;
      }
      
      public function getSomeWeaponInPackBackByName(_name:String) : MyEquipObj
      {
         for(var clen:uint = this.curarray.length; clen-- > 0; )
         {
            if(this.curarray[clen].getFillName() == _name)
            {
               return this.curarray[clen];
            }
         }
         for(var zlen:uint = this.zblist.length; zlen-- > 0; )
         {
            if(this.zblist[zlen].getFillName() == _name)
            {
               return this.zblist[zlen];
            }
         }
         return null;
      }
      
      public function removeSomeOneDJByFillName(fname:String) : void
      {
         var sit:int = 0;
         var temp:MyEquipObj = this.getSomeEquipInPackBackByName(fname);
         if(temp)
         {
            if(temp.getENum() > 1)
            {
               if(gc.isHideDebug)
               {
                  this.doSendAction(temp);
               }
               temp.setNum(-1);
            }
            else
            {
               if(gc.isHideDebug)
               {
                  this.doSendAction(temp);
               }
               sit = this.djlist.indexOf(temp);
               if(sit != -1)
               {
                  this.djlist.splice(sit,1);
               }
            }
         }
         temp = null;
      }
      
      private function doSendAction(equip:MyEquipObj) : void
      {
         var obj:* = null;
         if(gc.findOneTimeGoodsByFillName(equip.getFillName()))
         {
            obj = [];
            if(equip.getShopAttribtue() >= 1)
            {
               equip.setShopAttribute(equip.getShopAttribtue() - 1);
               obj.push(FinancialInfo.getItemIdByName(equip.getFillName(),0));
               obj.push(0);
               obj.push(1);
               obj.push(equip.getENum());
            }
            else
            {
               obj.push(FinancialInfo.getItemIdByName(equip.getFillName(),1));
               obj.push(0);
               obj.push(1);
               obj.push(equip.getENum());
            }
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[obj],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
      }
      
      public function removeSomeEquipFormBack(equip:MyEquipObj) : void
      {
      }
      
      public function getCurEquipByType(_type:String) : MyEquipObj
      {
         var clen:uint = this.curarray.length;
         while(clen-- > 0)
         {
            if(_type == this.curarray[clen].type)
            {
               return this.curarray[clen];
            }
         }
         return null;
      }
      
      public function getCurFashionEquipFallThingProbability() : Number
      {
         var curFashion:MyEquipObj = this.getCurEquipByType("zbsz");
         var probability:Number = 0;
         if(curFashion != null)
         {
            if(curFashion.getFillName() == "wkwdg" || curFashion.getFillName() == "tswdg" || curFashion.getFillName() == "bjwdg")
            {
               probability = 0.1;
            }
            else if(curFashion.getFillName() == "wkbsz" || curFashion.getFillName() == "tsbsz" || curFashion.getFillName() == "bjbsz")
            {
               probability = 0.18;
            }
            else if(curFashion.getFillName() == "wkzyf" || curFashion.getFillName() == "tszyf" || curFashion.getFillName() == "bjzyf")
            {
               probability = 0.2;
            }
         }
         return probability;
      }
      
      public function removeCurEquip(equip:MyEquipObj) : void
      {
         var sit:uint = this.curarray.indexOf(equip);
         if(sit != -1)
         {
            this.curarray.splice(sit,1);
         }
      }
      
      public function getSomeOneEquipNumberByName(fillname:String) : uint
      {
         var i:* = 0;
         var temp:* = null;
         var dlen:uint = this.djlist.length;
         for(i = uint(0); i < dlen; )
         {
            temp = this.djlist[i];
            if(temp.getFillName() == fillname)
            {
               return temp.getENum();
            }
            i++;
         }
         return 0;
      }
      
      public function setCurrentByType(_type:String, equip:MyEquipObj) : void
      {
         var clen:uint = this.curarray.length;
         while(clen-- > 0)
         {
            if(_type == this.curarray[clen].type)
            {
               this.curarray[clen] = equip;
            }
         }
      }
      
      public function removeEquipFormBack(equipname:String, pack:int, num:uint = 1) : void
      {
         var sit:int = 0;
         var equip:MyEquipObj = this.getSomeEquipInPackBackByName(equipname);
         var temp:MyEquipObj = this.getSomeEquipInPackBackByName(equip.getFillName());
         if(pack == 1)
         {
            if(equip.getENum() > 1)
            {
               equip.setNum(-1);
            }
            else
            {
               sit = this.zblist.indexOf(equip);
               if(sit != -1)
               {
                  this.zblist.splice(sit,1);
               }
            }
         }
         else if(pack == 2)
         {
            if(equip.getENum() > num)
            {
               equip.setNum(-num);
            }
            else
            {
               sit = this.djlist.indexOf(equip);
               if(sit != -1)
               {
                  this.djlist.splice(sit,1);
               }
            }
         }
         else if(pack == 4)
         {
            if(equip.getENum() > num)
            {
               equip.setNum(-num);
            }
            else
            {
               sit = this.jnslist.indexOf(equip);
               if(sit != -1)
               {
                  this.jnslist.splice(sit,1);
               }
            }
         }
      }
      
      public function getPetEquipSaveString() : String
      {
         var str:String = "";
         for(var zlen:uint = this.plist.length; zlen-- > 0; )
         {
            if(this.plist[zlen])
            {
               str += PetEquipObj(this.plist[zlen]).getEquipSaveObj();
               if(zlen != 0)
               {
                  str += "}";
               }
            }
         }
         return str;
      }
      
      public function getBagEquipSaveString() : String
      {
         var str:String = "";
         for(var zlen:uint = this.zblist.length; zlen-- > 0; )
         {
            if(this.zblist[zlen])
            {
               str += MyEquipObj(this.zblist[zlen]).getEquipSaveObj();
               if(zlen != 0)
               {
                  str += "}";
               }
            }
         }
         return str;
      }
      
      public function getCurEquipSaveString() : String
      {
         var str:String = "";
         for(var zlen:uint = this.curarray.length; zlen-- > 0; )
         {
            str += MyEquipObj(this.curarray[zlen]).getEquipSaveObj();
            if(zlen != 0)
            {
               str += "}";
            }
         }
         return str;
      }
      
      public function getBagDaoJuEquipSaveString() : String
      {
         var str:String = "";
         for(var zlen:uint = this.djlist.length; zlen-- > 0; )
         {
            if(this.djlist[zlen])
            {
               str += MyEquipObj(this.djlist[zlen]).getEquipSaveObj();
               if(zlen != 0)
               {
                  str += "}";
               }
            }
         }
         return str;
      }
      
      public function getBagSZEquipSaveString() : String
      {
         var str:String = "";
         for(var slen:uint = this.szlist.length; slen-- > 0; )
         {
            if(this.szlist[slen])
            {
               str += MyEquipObj(this.szlist[slen]).getEquipSaveObj();
               if(slen != 0)
               {
                  str += "}";
               }
            }
         }
         return str;
      }
      
      public function getBagJNSEquipSaveString() : String
      {
         var str:String = "";
         for(var slen:uint = this.jnslist.length; slen-- > 0; )
         {
            if(this.jnslist[slen])
            {
               str += MyEquipObj(this.jnslist[slen]).getEquipSaveObj();
               if(slen != 0)
               {
                  str += "}";
               }
            }
         }
         return str;
      }
      
      public function getSaveObj() : Object
      {
         saveObj.controlPlayer = this.controlPlayer;
         saveObj.lhValue = this.getLhValue();
         saveObj.myscore = this.getMyScore();
         saveObj.curExp = this.getCurExp();
         saveObj.curLevel = this.getCurLevel();
         saveObj.skillLimit = this.getSkillLimt();
         saveObj.roleid = this.roleid;
         saveObj.isstudyskill = this.isstudyskill;
         saveObj.skillbykey = this.skillbykey;
         saveObj.ispassiveskill = this.dataObject.ispassiveskill;
         saveObj.immortalitylist = this.immortalitylist;
         saveObj.hasstudybossskill = this.hasstudybossskill;
         saveObj.bossskillbykey = this.bossskillbykey;
         if(gc.allTask)
         {
            saveObj.allTask = gc.allTask.saveAllTask();
            saveObj.actTask = gc.allTask.saveActionTask();
            saveObj.rewTask = gc.allTask.saveRewardTask();
         }
         saveObj.saveDate = gc.dataObjectInstance.curDate;
         saveObj.petSave = this.getPetSaveString();
         saveObj.luckdata = this.getLuckData();
         saveObj.strenthtimes = this.dataObject.strenthtimes;
         saveObj.biggestpassiveskilllevel = this.dataObject.biggestpassiveskilllevel;
         saveObj.isshowfashion = this.isshowfashion;
         saveObj.bagSaveString = this.getBagEquipSaveString();
         saveObj.curSaveString = this.getCurEquipSaveString();
         saveObj.bagdjSaveString = this.getBagDaoJuEquipSaveString();
         saveObj.bagszSaveString = this.getBagSZEquipSaveString();
         saveObj.bagjnsSaveString = this.getBagJNSEquipSaveString();
         saveObj.petEquipSaveString = this.getPetEquipSaveString();
         return saveObj;
      }
      
      public function setSaveObj(readObj:Object, controlPlayer:int = -1) : void
      {
         var value:* = 0;
         var obj:* = null;
         var zlen:* = 0;
         var myEquipObj1:* = null;
         var dataArray:* = null;
         var bagSaveString:* = null;
         var dlen:* = 0;
         var myEquipObj3:* = null;
         var bagdjSaveString:* = null;
         var slen:* = 0;
         var myEquipObj4:* = null;
         var bagszSaveString:* = null;
         var jlen:* = 0;
         var myEquipObj5:* = null;
         var bagjnsSaveString:* = null;
         var clen:* = 0;
         var myEquipObj2:* = null;
         var curSaveString:* = null;
         var i:int = 0;
         var idx:int = 0;
         var plen:* = 0;
         var petEquip1:* = null;
         dataArray = null;
         var petEquipSaveString:* = null;
         var getArray:* = null;
         trace("-------setSaveObj-------");
         this.zblist = [];
         this.djlist = [];
         this.szlist = [];
         this.jnslist = [];
         this.curarray = [];
         this.plist = [];
         this.curEquipType = ["zbwq","zbfj","zbsp","zbfb","zbsz","zbtx"];
         if(controlPlayer == -1)
         {
            this.controlPlayer = readObj.controlPlayer;
         }
         else
         {
            this.controlPlayer = controlPlayer;
         }
         this.setLhValue(readObj.lhValue);
         this.setMyScore(readObj.myscore);
         this.setCurExp(readObj.curExp);
         this.setCurLevel(readObj.curLevel);
         if(this.getCurLevel() > gc.getTotalTopLevel())
         {
            this.setCurLevel(gc.getTotalTopLevel());
            this.setCurExp(0);
         }
         if(this.getCurLevel() == gc.getTotalTopLevel())
         {
            value = uint(5000 + 5000 * (this.getCurLevel() - 19));
            if(this.getCurExp() > value)
            {
               this.setCurExp(value);
            }
         }
         this.setSkillLimit(readObj.skillLimit);
         this.roleid = readObj.roleid;
         this.isstudyskill = readObj.isstudyskill;
         this.skillbykey = readObj.skillbykey;
         for(var sklen:uint = this.skillbykey.length; sklen-- > 0; )
         {
            if(this.skillbykey[sklen])
            {
               this.skillbykey[sklen].needLh = gc.findLhValueBySkillName(this.skillbykey[sklen].skillName);
               if(this.skillbykey[sklen].slev > 3)
               {
                  this.setSkillLevelInTheAllSkillAry(this.skillbykey[sklen].skillName,3);
               }
            }
         }
         if(readObj.immortalitylist != undefined)
         {
            this.immortalitylist = readObj.immortalitylist;
            this.immortalitylist[2].canuse = true;
            this.immortalitylist[3].canuse = true;
            this.immortalitylist[4].canuse = true;
         }
         this.setStrengthLevel();
         this.dataObject.ispassiveskill = readObj.ispassiveskill;
         if(readObj.hasstudybossskill != undefined)
         {
            this.hasstudybossskill = readObj.hasstudybossskill;
         }
         if(readObj.bossskillbykey != undefined)
         {
            this.bossskillbykey = readObj.bossskillbykey;
            obj = this.findBossSkillByBossSkillType(1);
            if(obj != null)
            {
               this.bossskillbykey = [obj];
            }
         }
         var dataXml:XML = Aloader2.getInstance().decryptXml();
         gc.dataXml = dataXml;
         this.savePetSaveString(readObj.petSave,dataXml);
         this.setExAry(gc.luanqibazaojiami.saveId,this.roleid);
         if(gc.player3 != this)
         {
            if(gc.dataObjectInstance.curDate == readObj.saveDate)
            {
               if(gc.allTask)
               {
                  gc.allTask.setAllTask(readObj.allTask);
               }
               this.setLuckData(readObj.luckdata);
               if(gc.allTask && readObj.rewTask != undefined && readObj.rewTask != "")
               {
                  gc.allTask.setRewTask(readObj.rewTask);
               }
            }
            else
            {
               this.setTadayLuckValue();
            }
            if(gc.allTask && readObj.actTask != undefined && readObj.actTask != "")
            {
               gc.allTask.setActTask(readObj.actTask);
            }
         }
         if(readObj.strenthtimes != undefined && readObj.strenthtimes != "undefined")
         {
            this.dataObject.strenthtimes = int(readObj.strenthtimes);
         }
         if(readObj.biggestpassiveskilllevel != undefined)
         {
            this.dataObject.biggestpassiveskilllevel = readObj.biggestpassiveskilllevel;
         }
         if(readObj.isshowfashion)
         {
            this.isshowfashion = readObj.isshowfashion;
         }
         trace("-------2222222-------");
         if(readObj.bagSaveString != undefined)
         {
            bagSaveString = readObj.bagSaveString;
            dataArray = bagSaveString.split("}");
            for(zlen = uint(dataArray.length); zlen-- > 0; )
            {
               if(dataArray[zlen] != "")
               {
                  myEquipObj1 = new MyEquipObj();
                  myEquipObj1.setEquipSaveObj(dataArray[zlen]);
                  myEquipObj1.checkDataAbnormal(dataXml.equip.equipment.(@fillname == myEquipObj1.getFillName()));
                  this.zblist.push(myEquipObj1);
               }
            }
         }
         trace("-------33333333-------");
         if(readObj.bagdjSaveString != undefined)
         {
            bagdjSaveString = readObj.bagdjSaveString;
            if(bagdjSaveString.charAt(bagdjSaveString.length - 1) == "}")
            {
               bagdjSaveString = bagdjSaveString.substr(0,bagdjSaveString.length - 2);
            }
            dataArray = bagdjSaveString.split("}");
            for(dlen = uint(dataArray.length); dlen-- > 0; )
            {
               if(dataArray[dlen] != "")
               {
                  myEquipObj3 = new MyEquipObj();
                  myEquipObj3.setEquipSaveObj(bagdjSaveString.split("}")[dlen]);
                  if(myEquipObj3.type == "zbtx")
                  {
                     this.zblist.push(myEquipObj3);
                  }
                  else
                  {
                     this.djlist.push(myEquipObj3);
                  }
               }
            }
         }
         trace("-------44444444444-------");
         if(readObj.bagszSaveString != undefined)
         {
            bagszSaveString = readObj.bagszSaveString;
            if(bagszSaveString.charAt(bagszSaveString.length - 1) == "}")
            {
               bagszSaveString = bagszSaveString.substr(0,bagszSaveString.length - 2);
            }
            dataArray = bagszSaveString.split("}");
            for(slen = uint(dataArray.length); slen-- > 0; )
            {
               if(dataArray[slen] != "")
               {
                  myEquipObj4 = new MyEquipObj();
                  myEquipObj4.setEquipSaveObj(bagszSaveString.split("}")[slen]);
                  myEquipObj4.checkDataAbnormal(dataXml.equip.equipment.(@fillname == myEquipObj4.getFillName()));
                  this.szlist.push(myEquipObj4);
               }
            }
         }
         trace("-------5555555555555-------");
         if(readObj.bagjnsSaveString != undefined)
         {
            bagjnsSaveString = readObj.bagjnsSaveString;
            if(bagjnsSaveString.charAt(bagjnsSaveString.length - 1) == "}")
            {
               bagjnsSaveString = bagjnsSaveString.substr(0,bagjnsSaveString.length - 2);
            }
            dataArray = bagjnsSaveString.split("}");
            for(jlen = uint(dataArray.length); jlen-- > 0; )
            {
               if(dataArray[jlen] != "")
               {
                  myEquipObj5 = new MyEquipObj();
                  myEquipObj5.setEquipSaveObj(bagjnsSaveString.split("}")[jlen]);
                  this.jnslist.push(myEquipObj5);
               }
            }
         }
         trace("-------66666666666-------readObj.curSaveString:" + readObj.curSaveString);
         if(readObj.curSaveString != undefined)
         {
            curSaveString = readObj.curSaveString;
            if(curSaveString.charAt(curSaveString.length - 1) == "}")
            {
               curSaveString = curSaveString.substr(0,curSaveString.length - 2);
            }
            dataArray = curSaveString.split("}");
            clen = uint(dataArray.length);
            i = 0;
            while(i < clen)
            {
               if(dataArray[i] != "")
               {
                  myEquipObj2 = new MyEquipObj();
                  myEquipObj2.setEquipSaveObj(curSaveString.split("}")[i]);
                  myEquipObj2.checkDataAbnormal(dataXml.equip.equipment.(@fillname == myEquipObj2.getFillName()));
                  if(!gc.allEquip.isTheSameEquipmentByFillName(myEquipObj2))
                  {
                     trace("current equipment is modify!!");
                     i++;
                  }
                  else
                  {
                     if(this.curEquipType.length > 0)
                     {
                        if(myEquipObj2.type)
                        {
                           idx = this.curEquipType.indexOf(myEquipObj2.type);
                           if(idx != -1)
                           {
                              if(myEquipObj2.type == "zbsz")
                              {
                                 if(myEquipObj2.hasPassTime())
                                 {
                                    this.szlist.push(myEquipObj2);
                                 }
                                 else
                                 {
                                    this.curarray.push(myEquipObj2);
                                    this.curEquipType.splice(idx,1);
                                 }
                              }
                              else if(myEquipObj2.type != "zbcb")
                              {
                                 this.curarray.push(myEquipObj2);
                                 this.curEquipType.splice(idx,1);
                              }
                           }
                           else
                           {
                              this.zblist.push(myEquipObj2);
                           }
                        }
                     }
                     i++;
                  }
               }
               else
               {
                  trace("i -->>" + i + "  dataArray[i] -->>" + dataArray[i] + " data i is \'\'");
                  i++;
               }
            }
         }
         trace("-------777777777777-------");
         if(readObj.petEquipSaveString != undefined)
         {
            petEquipSaveString = readObj.petEquipSaveString;
            dataArray = petEquipSaveString.split("}");
            for(plen = uint(dataArray.length); plen-- > 0; )
            {
               if(dataArray[plen] != "")
               {
                  petEquip1 = new PetEquipObj();
                  getArray = dataArray[plen].split("|");
                  if(!(getArray[0] == "p_yxkx" || getArray[0] == "p_jlkx" || getArray[0] == "p_sskx" || getArray[0] == "p_yxhh" || getArray[0] == "p_jlhh" || getArray[0] == "p_sshh"))
                  {
                     petEquip1.setEquipSaveObj(dataArray[plen]);
                     petEquip1.checkDataAbnormal(dataXml.petequip.pequip.(@fillname == petEquip1.getFillName()));
                     this.plist.push(petEquip1);
                  }
               }
            }
         }
         trace("-------88888888-------");
      }
      
      public function checkHasSomePet(pname:String) : Boolean
      {
         for(var plen:uint = this.petsAry.length; plen-- > 0; )
         {
            if(PetInfo(this.petsAry[plen]).getPetName() == pname)
            {
               return true;
            }
         }
         return false;
      }
      
      private function setStrengthLevel() : void
      {
         for(var slen:uint = this.skillbykey.length; slen-- > 0; )
         {
            if(this.skillbykey.slev == undefined)
            {
               this.skillbykey.slev = 1;
            }
         }
      }
      
      public function setTadayLuckValue() : void
      {
         if(gc.gameVip)
         {
            if(gc.gameVip.getVipLevel() >= 1)
            {
               this.setLuckData(20);
            }
            else if(this.getCurLevel() <= 4)
            {
               this.setLuckData(1 + Math.round(RandomControllor.getIns().getRandom() * 4));
            }
            else if(this.getCurLevel() >= 5 && this.getCurLevel() <= 10)
            {
               this.setLuckData(1 + Math.round(RandomControllor.getIns().getRandom() * 9));
            }
            else
            {
               this.setLuckData(1 + Math.round(RandomControllor.getIns().getRandom() * 19));
            }
         }
      }
      
      private function getPetSaveString() : String
      {
         var i:* = 0;
         var plen:uint = this.petsAry.length;
         var saveStr:String = "";
         for(i = uint(0); i < plen; )
         {
            saveStr += PetInfo(this.petsAry[i]).getSaveString();
            if(i != plen - 1)
            {
               saveStr += "}";
            }
            i++;
         }
         return saveStr;
      }
      
      private function savePetSaveString(data:String, checkXml:XML) : void
      {
         var plen:int = 0;
         var pet:* = null;
         this.petsAry.length = 0;
         var dataArray:Array = data.split("}");
         for(var dlen:uint = dataArray.length; dlen-- > 0; )
         {
            if(dataArray[dlen] != "")
            {
               pet = new PetInfo();
               pet.setSaveString(dataArray[dlen]);
               pet.checkDataAbnormal(checkXml.pet.gamepet.(@petname == pet.getPetPreName()));
               this.petsAry.push(pet);
            }
         }
         var isHasFlight:Boolean = false;
         for each(var pi in this.petsAry)
         {
            if(!isHasFlight)
            {
               if(pi.isFight == 1)
               {
                  isHasFlight = true;
               }
            }
            else
            {
               pi.isFight = 0;
            }
         }
      }
      
      public function setExAry(sid:int = -1, rid:int = -1, bid:int = -1) : void
      {
         if(sid != -1)
         {
            exAry[0] = sid;
         }
         if(rid != -1)
         {
            exAry[1] = rid;
         }
         if(bid != -1)
         {
            exAry[2] = bid;
         }
      }
      
      public function getRoleName() : String
      {
         var roleName:String = "";
         if(this.roleid == 1)
         {
            roleName = "孙悟空";
         }
         else if(this.roleid == 2)
         {
            roleName = "唐僧";
         }
         else if(this.roleid == 3)
         {
            roleName = "八戒";
         }
         else if(this.roleid == 4)
         {
            roleName = "沙僧";
         }
         return roleName;
      }
      
      public function returnSkillNameBySkillKey(key:String) : Array
      {
         var slen:uint = this.skillbykey.length;
         for(var openSkill:Array = ["sx","hmz","tmc","mds","jhsj","smb","mmw","hyjj","syzq","lyfb","tjgl","xgq","tkj"]; slen-- > 0; )
         {
            if(this.skillbykey[slen].keys == key)
            {
               if(openSkill.indexOf(this.skillbykey[slen].skillName) != -1)
               {
                  if(this.skillbykey[slen].slev > 3)
                  {
                     this.skillbykey[slen].slev = 1;
                  }
               }
               else
               {
                  this.skillbykey[slen].slev = 1;
               }
               return [this.skillbykey[slen].skillName,gc.findLhValueBySkillName(this.skillbykey[slen].skillName) * (1 + (this.skillbykey[slen].slev - 1) * 0.5),this.skillbykey[slen].slev];
            }
         }
         return null;
      }
      
      public function returnSkillLevelBySkillName(sname:String) : int
      {
         var slen:uint = this.skillbykey.length;
         for(var openSkill:Array = ["sx","hmz","tmc","mds","jhsj","smb","mmw","hyjj","syzq","lyfb","tjgl","xgq","tkj"]; slen-- > 0; )
         {
            if(this.skillbykey[slen].skillName == sname)
            {
               if(this.skillbykey[slen].slev == undefined || int(this.skillbykey[slen].slev) == 0)
               {
                  this.skillbykey[slen].slev = 1;
               }
               if(openSkill.indexOf(sname) != -1)
               {
                  if(this.skillbykey[slen].slev > 3)
                  {
                     this.skillbykey[slen].slev = 1;
                     return 1;
                  }
                  return this.skillbykey[slen].slev;
               }
               this.skillbykey[slen].slev = 1;
               return 1;
            }
         }
         return 1;
      }
      
      public function findBossSkillByBossSkillType(type:uint) : Object
      {
         var typeKeys:* = null;
         if(type == 2 || type == 3)
         {
            return null;
         }
         if(type == 1)
         {
            if(this.controlPlayer == 0)
            {
               typeKeys = "SSJ";
            }
            else
            {
               typeKeys = "↓↓1";
            }
         }
         else if(type == 2)
         {
            if(this.controlPlayer == 0)
            {
               typeKeys = "WWJ";
            }
            else
            {
               typeKeys = "↑↑1";
            }
         }
         else if(type == 3)
         {
            if(this.controlPlayer == 0)
            {
               typeKeys = "SWJ";
            }
            else
            {
               typeKeys = "↓↑1";
            }
         }
         for(var blen:uint = this.bossskillbykey.length; blen-- > 0; )
         {
            if(this.bossskillbykey[blen])
            {
               if(this.bossskillbykey[blen].keys == typeKeys)
               {
                  return this.bossskillbykey[blen];
               }
            }
         }
         return null;
      }
      
      public function returnSkillObjBySkillKey(key:String) : Object
      {
         for(var slen:uint = this.skillbykey.length; slen-- > 0; )
         {
            if(this.skillbykey[slen].keys == key)
            {
               return this.skillbykey[slen];
            }
         }
         for(var blen:uint = this.bossskillbykey.length; blen-- > 0; )
         {
            if(this.bossskillbykey[blen].keys == key)
            {
               return this.bossskillbykey[blen];
            }
         }
         return null;
      }
      
      public function findSkillIsInTheSkillAry(sname:String) : Boolean
      {
         for(var slen:uint = this.skillbykey.length; slen-- > 0; )
         {
            if(this.skillbykey[slen].skillName == sname)
            {
               return true;
            }
         }
         return false;
      }
      
      public function returnSkillIsInTheSkillAry(sname:String) : Object
      {
         for(var slen:uint = this.skillbykey.length; slen-- > 0; )
         {
            if(this.skillbykey[slen].skillName == sname)
            {
               return this.skillbykey[slen];
            }
         }
         return null;
      }
      
      public function setSkillLevelInTheAllSkillAry(sname:String, lev:uint) : void
      {
         var sary:* = null;
         var i:* = 0;
         var lary:* = null;
         var sit:int = 0;
         var ilen:uint = isstudyskill.length;
         loop0:
         for(var obj:Object = {}; ilen-- > 0; )
         {
            obj = isstudyskill[ilen];
            sary = obj.skillName.split("|");
            if(sary)
            {
               for(i = uint(0); i < sary.length; )
               {
                  lary = sary[i].split("~");
                  sit = lary.indexOf(sname);
                  if(sit != -1)
                  {
                     sary[i] = lary[sit] + "~" + lev;
                     obj.skillName = "";
                     for each(var str in sary)
                     {
                        if(str != "")
                        {
                           obj.skillName += str + "|";
                        }
                     }
                     continue loop0;
                  }
                  i++;
               }
            }
         }
         trace("isstudyskill[1].skillName ==" + isstudyskill[1].skillName);
      }
      
      public function findCurrentPet(isreturnzerolifepet:Boolean = false) : PetInfo
      {
         for(var plen:uint = this.petsAry.length; plen-- > 0; )
         {
            if(this.petsAry[plen].isFight == 1)
            {
               if(this.petsAry[plen].getlifetime() > 0)
               {
                  return this.petsAry[plen];
               }
               if(isreturnzerolifepet)
               {
                  return this.petsAry[plen];
               }
            }
         }
         return null;
      }
      
      public function findBiggestPetLevel() : int
      {
         var bigger:* = int(0);
         for(var plen:uint = this.petsAry.length; plen-- > 0; )
         {
            bigger = PetInfo(this.petsAry[plen]).getLevel() > bigger ? PetInfo(this.petsAry[plen]).getLevel() : bigger;
         }
         return bigger;
      }
      
      public function catchNewPet(pname:String, plevel:uint = 1) : Boolean
      {
         var plen:uint = this.petsAry.length;
         if(gc.gameVip && gc.gameVip.getVipLevel() >= 3)
         {
            if(plen >= 10)
            {
               return false;
            }
         }
         else if(plen >= 1 + int(this.getCurLevel() / 10) || plen >= 5)
         {
            return false;
         }
         var newPet:PetInfo = new PetInfo();
         newPet.setPetNameAndLevel(pname,plevel);
         this.petsAry.push(newPet);
         return true;
      }
      
      public function howMuchSkillHasYouStudy() : uint
      {
         var skillAry:* = null;
         var i:* = 0;
         var slen:uint = 0;
         for(i = uint(0); i < 2; )
         {
            skillAry = String(this.isstudyskill[i].skillName).split("|");
            slen += skillAry.length - 1;
            i++;
         }
         return slen;
      }
      
      public function getSkillStringBySkillName(sname:String) : Array
      {
         var sary:* = null;
         var len:* = 0;
         var i:* = 0;
         var lary:* = null;
         var ilen:uint = this.isstudyskill.length;
         for each(var obj in this.isstudyskill)
         {
            if(obj.skillName.indexOf(sname) != -1)
            {
               sary = obj.skillName.split("|");
               len = uint(sary.length);
               for(i = uint(0); i < len; )
               {
                  lary = sary[i].split("~");
                  if(lary.indexOf(sname) != -1)
                  {
                     return lary;
                  }
                  i++;
               }
            }
         }
         return null;
      }
      
      public function getSkillLevelBySkillName(sname:String) : int
      {
         var sary:* = null;
         var len:* = 0;
         var i:* = 0;
         var lary:* = null;
         var ilen:uint = this.isstudyskill.length;
         for each(var obj in this.isstudyskill)
         {
            if(obj.skillName.indexOf(sname) != -1)
            {
               sary = obj.skillName.split("|");
               len = uint(sary.length);
               for(i = uint(0); i < len; )
               {
                  lary = sary[i].split("~");
                  if(lary.indexOf(sname) != -1)
                  {
                     return int(lary[1]);
                  }
                  i++;
               }
            }
         }
         return 0;
      }
      
      public function findWhichSkillBtnNoneSet() : String
      {
         var sit:int = 0;
         var hasbtn:String = "";
         var btnAry:Array = [];
         if(this.controlPlayer == 0)
         {
            btnAry = ["Y","U","I","O","L"];
         }
         else
         {
            btnAry = ["8","4","5","6","3"];
         }
         for(var slen:uint = this.skillbykey.length; slen-- > 0; )
         {
            if(this.skillbykey[slen])
            {
               sit = btnAry.indexOf(this.skillbykey[slen].keys);
               if(sit != -1)
               {
                  btnAry.splice(sit,1);
               }
            }
         }
         if(btnAry[0])
         {
            hasbtn = btnAry[0];
         }
         return hasbtn;
      }
      
      private function findWhichBossSkillBtnNoneSet() : String
      {
         var sit:int = 0;
         var hasbtn:String = "";
         var btnAry:Array = [];
         if(this.controlPlayer == 0)
         {
            btnAry = ["SSJ"];
         }
         else
         {
            btnAry = ["↓↓1"];
         }
         for(var blen:uint = this.bossskillbykey.length; blen-- > 0; )
         {
            if(this.bossskillbykey[blen])
            {
               sit = btnAry.indexOf(this.bossskillbykey[blen].keys);
               if(sit != -1)
               {
                  btnAry.splice(sit,1);
               }
            }
         }
         if(btnAry[0])
         {
            hasbtn = btnAry[0];
         }
         return hasbtn;
      }
      
      public function achieveBossSkill(mname:String) : void
      {
         var obj:* = null;
         trace("MonsterName--->>" + mname);
         var bsname:String = this.findBossSkillNameByBossName(mname);
         if(bsname == "")
         {
            return;
         }
         this.hasstudybossskill.push(bsname);
         var btn:String = this.findWhichBossSkillBtnNoneSet();
         trace("没用掉的字段btn---->>" + btn);
         if(btn != "")
         {
            obj = {
               "skillName":bsname,
               "keys":btn,
               "needLh":this.findBossSkillNeedMp(bsname)
            };
            this.bossskillbykey.push(obj);
         }
      }
      
      public function findBossSkillNameByBossName(mname:String) : String
      {
         switch(mname)
         {
            case "千里眼":
               return "bs_qlj";
            case "顺风耳":
               return "bs_nh";
            case "巨灵神":
               return "bs_xz";
            case "增长天王":
               return "bs_sfjz";
            case "广目天王":
               return "bs_hlcj";
            case "多闻天王":
               return "bs_tl";
            case "朱子真":
               return "bs_jt";
            case "袁洪":
               return "bs_lx";
            case "二郎神":
               return "bs_syfy";
            case "轸宿":
               return "bs_erishiba_1";
            case "翼火蛇":
               return "bs_erishiba_2";
            case "张月鹿":
               return "bs_erishiba_3";
            case "星日马":
               return "bs_erishiba_4";
            case "柳宿":
               return "bs_erishiba_5";
            case "鬼宿":
               return "bs_erishiba_6";
            case "井宿":
               return "bs_erishiba_7";
            case "壁宿":
               return "bs_erishiba_8";
            case "室宿":
               return "bs_erishiba_9";
            case "危宿":
               return "bs_erishiba_10";
            case "虚宿":
               return "bs_erishiba_11";
            case "女宿":
               return "bs_erishiba_12";
            case "牛宿":
               return "bs_erishiba_13";
            case "斗宿":
               return "bs_erishiba_14";
            default:
               return "";
         }
      }
      
      public function findBossSkillNeedMp(sname:String) : uint
      {
         return 140;
      }
      
      public function findAllImmortalityAddHp() : uint
      {
         var alladd:* = 0;
         var elen:* = 0;
         for(var ilen:uint = this.immortalitylist.length; ilen-- > 0; )
         {
            for(elen = uint(this.immortalitylist[ilen].usenum); elen-- > 0; )
            {
               if(ilen == 4)
               {
                  alladd += 350;
               }
               else if(ilen == 3)
               {
                  alladd += 300;
               }
               else if(ilen == 2)
               {
                  alladd += 250;
               }
               else if(ilen == 1)
               {
                  alladd += 200;
               }
               else if(ilen == 0)
               {
                  alladd += 150;
               }
            }
         }
         if(alladd > 5500)
         {
            alladd = uint(5500);
         }
         return alladd;
      }
      
      public function reSetAllPetState() : void
      {
         for(var plen:uint = this.petsAry.length; plen-- > 0; )
         {
            PetInfo(this.petsAry[plen]).reSetPetState();
         }
      }
      
      public function removeSomeEquip(fname:String, num:int) : void
      {
         var sit:int = 0;
         var temp:MyEquipObj = this.getSomeEquipInPackBackByName(fname);
         if(temp.getENum() > num)
         {
            temp.setNum(-num);
         }
         else
         {
            sit = this.djlist.indexOf(temp);
            if(sit != -1)
            {
               this.djlist.splice(sit,1);
            }
         }
      }
      
      public function doWhenCljBroken() : void
      {
         var newEquip:* = null;
         var curSp:MyEquipObj = this.getCurEquipByType("zbsp");
         if(curSp == null)
         {
            return;
         }
         if(curSp.getFillName() == "clj")
         {
            newEquip = gc.allEquip.findByName("psdclj");
            newEquip.setstrengthValue(curSp.getStrengthValue());
            newEquip.strengthenEquip();
            this.setCurrentByType("zbsp",newEquip);
         }
      }
      
      public function doWhenCljReduction() : void
      {
         trace("--doWhenCljReduction--");
         var newEquip:MyEquipObj = gc.allEquip.findByName("clj");
         var curSp:MyEquipObj = this.getSomeWeaponInPackBackByName("psdclj");
         newEquip.setstrengthValue(curSp.getStrengthValue());
         newEquip.strengthenEquip();
         var idx:int = this.curarray.indexOf(curSp);
         if(idx != -1)
         {
            this.curarray.splice(idx,1);
            this.curarray.push(newEquip);
         }
         else
         {
            idx = this.zblist.indexOf(curSp);
            if(idx != -1)
            {
               this.zblist.splice(idx,1);
               this.zblist.push(newEquip);
            }
         }
      }
      
      public function checkPassiveSkillAndPill() : void
      {
         var i:* = 0;
         var len:uint = this.dataObject.ispassiveskill.length;
         for(i = uint(0); i < len; )
         {
            if(int(this.dataObject.ispassiveskill[i]) > 5)
            {
               this.dataObject.ispassiveskill[i] = 5;
            }
            i++;
         }
      }
      
      public function setSkillKeyPlayer3() : void
      {
         var i:int = 0;
         var key:* = null;
         var keyLen:int = this.skillbykey.length;
         for(i = 0; i < keyLen; )
         {
            key = this.skillbykey[i];
            if(key.keys == "Y")
            {
               key.keys = "8";
            }
            else if(key.keys == "U")
            {
               key.keys = "4";
            }
            else if(key.keys == "I")
            {
               key.keys = "5";
            }
            else if(key.keys == "O")
            {
               key.keys = "6";
            }
            else if(key.keys == "L")
            {
               key.keys = "3";
            }
            i++;
         }
         for each(var bossSkill in this.bossskillbykey)
         {
            bossSkill.keys = "↓↓1";
         }
      }
   }
}

package my
{
   import com.superkaka.game.Const.GameConst;
   import config.Config;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import loader.AssetsManager;
   import mvc.controllor.PlayerDatasControllor;
   import petInfo.PetInfo;
   
   public class Decrypt extends Sprite
   {
       
      
      public var ezDecrypt;
      
      private var currentFileIdx:int;
      
      private var uloader:URLLoader;
      
      private var after:Function;
      
      private var afterName:String = "";
      
      private var loadSwfsWhenStage0:Array;
      
      private var loadSwfsWhenStage3:Array;
      
      private var loadSwfsWhenStage4:Array;
      
      private var loadSwfsWhenStage10:Array;
      
      private var loadSwfsWhenStage13:Array;
      
      private var loadSwfsWhenStage14:Array;
      
      private var loadSwfsWhenStage20:Array;
      
      private var loadSwfsWhenStage21:Array;
      
      private var loadSwfsWhenStage22:Array;
      
      private var loadSwfsWhenStage23:Array;
      
      private var loadSwfsWhenStage24:Array;
      
      private var loadSwfsWhenStage25:Array;
      
      private var loadSwfsWhenStage46:Array;
      
      private var loadSwfsWhenStage47:Array;
      
      private var loadSwfsWhenStage52:Array;
      
      private var loadSwfsWhenStage54:Array;
      
      private var loadSwfsWhenStage55:Array;
      
      private var loadSwfsWhenStage56:Array;
      
      private var loadSwfsWhenStage58:Array;
      
      private var loadSwfsWhenStage59:Array;
      
      private var loadSwfsWhenStage60:Array;
      
      private var loadSwfsWhenStage61:Array;
      
      private var loadSwfsWhenStage63:Array;
      
      private var loadSwfsWhenStage64:Array;
      
      private var loadSwfsWhenStage65:Array;
      
      private var loadSwfsWhenStageCopy:Array;
      
      private var loadSwfsTotalLen:uint = 0;
      
      private var gc:Config;
      
      private var retryTimes:uint = 3;
      
      public function Decrypt()
      {
         loadSwfsWhenStage0 = ["Monster179","24"];
         loadSwfsWhenStage3 = ["Monster22"];
         loadSwfsWhenStage4 = ["Monster172"];
         loadSwfsWhenStage10 = ["Monster47"];
         loadSwfsWhenStage13 = ["12","2","3","4","5"];
         loadSwfsWhenStage14 = ["Monster60"];
         loadSwfsWhenStage20 = ["43"];
         loadSwfsWhenStage21 = ["45"];
         loadSwfsWhenStage22 = ["4"];
         loadSwfsWhenStage23 = ["21"];
         loadSwfsWhenStage24 = ["15"];
         loadSwfsWhenStage25 = ["15","21","4","Monster215"];
         loadSwfsWhenStage46 = ["9","Monster47","Monster60","Monster216","Monster180","49","Monster22"];
         loadSwfsWhenStage47 = ["47t2v650"];
         loadSwfsWhenStage52 = [];
         loadSwfsWhenStage54 = ["5","2"];
         loadSwfsWhenStage55 = ["Monster179"];
         loadSwfsWhenStage56 = [];
         loadSwfsWhenStage58 = ["Monster191"];
         loadSwfsWhenStage59 = ["Monster204"];
         loadSwfsWhenStage60 = ["4"];
         loadSwfsWhenStage61 = ["15"];
         loadSwfsWhenStage63 = ["5","2"];
         loadSwfsWhenStage64 = ["5"];
         loadSwfsWhenStage65 = ["47","15"];
         loadSwfsWhenStageCopy = [];
         super();
         Security.allowDomain("*");
         gc = Config.getInstance();
         loadSwfsWhenStage52.push(gc.getPetSwfNameByPetName("turtle"));
         loadSwfsWhenStage0.push(gc.getPetSwfNameByPetName("turtle"));
      }
      
      public function doWhenUserLogOut() : void
      {
         if(uloader)
         {
            uloader.removeEventListener("complete",this.loadCompleteHandler);
            uloader.removeEventListener("progress",this.loadByStageAndLevelProgress);
            uloader = null;
            GMain.getInstance().processComplete();
         }
      }
      
      public function doDecrypt(_arg1:String, _arg2:Function, _arg3:int) : void
      {
         var url:* = _arg1;
         this.after = _arg2;
         this.currentFileIdx = _arg3;
         uloader = new URLLoader();
         uloader.dataFormat = "binary";
         uloader.addEventListener("complete",completeHandler);
         uloader.load(new URLRequest(url));
         uloader.addEventListener("progress",this.__progress);
      }
      
      private function completeHandler(_arg1:*) : *
      {
         uloader.removeEventListener("complete",completeHandler);
         var _local3:ByteArray = uloader.data as ByteArray;
         var _local4:ByteArray = new ByteArray();
         trace("_local3:" + _local3.length + "," + _local3.bytesAvailable);
         _local4.writeBytes(_local3,300,25);
         _local4.writeBytes(_local3,0,300);
         _local4.writeBytes(_local3,325);
         var _local5:Loader = new Loader();
         _local5.loadBytes(_local4,new LoaderContext(false,ApplicationDomain.currentDomain));
         _local5.unload();
         _local5 = null;
         uloader.removeEventListener("progress",__progress);
         uloader.close();
         uloader = null;
         this.after();
      }
      
      private function __progress(_arg1:ProgressEvent) : void
      {
         var _local2:int = int(_arg1.bytesLoaded / _arg1.bytesTotal * 100);
         GMain.getInstance().showProgress(_local2,this.currentFileIdx);
      }
      
      public function loadByName(name:String, func:Function) : void
      {
         var obj:* = null;
         if(name == "0")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage0.concat();
         }
         else if(name == "3")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage3.concat();
         }
         else if(name == "4")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage4.concat();
            this.loadSwfsWhenStageCopy.push(gc.getPetSwfNameByPetName("dragon"));
            this.loadSwfsWhenStageCopy.push(gc.getPetSwfNameByPetName("tigress"));
            this.loadSwfsWhenStageCopy.push(gc.getPetSwfNameByPetName("phoenix"));
            this.loadSwfsWhenStageCopy.push(gc.getPetSwfNameByPetName("turtle"));
         }
         else if(name == "10")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage10.concat();
         }
         else if(name == "13")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage13.concat();
         }
         else if(name == "14")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage14.concat();
         }
         else if(name == "20")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage20.concat();
         }
         else if(name == "21")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage21.concat();
         }
         else if(name == "22")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage22.concat();
         }
         else if(name == "23")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage23.concat();
         }
         else if(name == "24")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage24.concat();
         }
         else if(name == "25")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage25.concat();
         }
         else if(name == "46")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage46.concat();
         }
         else if(name == "47")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage47.concat();
         }
         else if(name == "52")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage52.concat();
         }
         else if(name == "54")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage54.concat();
         }
         else if(name == "55")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage55.concat();
         }
         else if(name == "56")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage56.concat();
         }
         else if(name == "58")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage58.concat();
         }
         else if(name == "59")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage59.concat();
         }
         else if(name == "60")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage60.concat();
         }
         else if(name == "61")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage61.concat();
         }
         else if(name == "63")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage63.concat();
         }
         else if(name == "64")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage64.concat();
            this.loadSwfsWhenStageCopy.push(gc.getPetSwfNameByPetName("mouse"));
            this.loadSwfsWhenStageCopy.push(gc.getPetSwfNameByPetName("neat"));
            this.loadSwfsWhenStageCopy.push(gc.getPetSwfNameByPetName("terribletiger"));
         }
         else if(name == "65")
         {
            this.loadSwfsWhenStageCopy = this.loadSwfsWhenStage65.concat();
         }
         else
         {
            this.loadSwfsWhenStageCopy.length = 0;
         }
         this.loadSwfsWhenStageCopy.unshift("stageCommonv1270");
         this.loadSwfsWhenStageCopy.unshift("stageInfov1620");
         var roleAndPetArray:Array = this.getRoleAndPetAssets();
         this.loadSwfsWhenStageCopy = this.loadSwfsWhenStageCopy.concat(roleAndPetArray);
         this.loadSwfsWhenStageCopy.push(name);
         if(gc.allTask)
         {
            obj = gc.allTask.getMonsterBirth();
            if(obj)
            {
               if(gc.curStageAndCurLevel.curStage == obj.stage && gc.curStageAndCurLevel.curLevel == obj.level)
               {
                  if(int(obj.mname) == 138)
                  {
                     this.loadSwfsWhenStageCopy.push("Monster22");
                  }
                  else if(int(obj.mname) == 180)
                  {
                     this.loadSwfsWhenStageCopy.push("Monster180");
                  }
                  else if(int(obj.mname) == 215)
                  {
                     this.loadSwfsWhenStageCopy.push("Monster215");
                  }
                  else if(int(obj.mname) == 216)
                  {
                     this.loadSwfsWhenStageCopy.push("Monster216");
                  }
               }
            }
         }
         if(gc.curStageAndCurLevel.curStage >= 1 && gc.curStageAndCurLevel.curStage <= 3 || gc.curStageAndCurLevel.curStage >= 20 && gc.curStageAndCurLevel.curStage <= 23)
         {
            this.loadSwfsWhenStageCopy.push("Monster204");
         }
         if(gc.dataObject.houyiTimes > 0)
         {
            this.loadSwfsWhenStageCopy.push("Monster172");
         }
         if(gc.dataObject.yuelaoTimes > 0)
         {
            this.loadSwfsWhenStageCopy.push("Monster191");
         }
         this.loadSwfsWhenStageCopy.push("Monster148");
         this.loadSwfsWhenStageCopy.push("Monster217");
         this.loadSwfsWhenStageCopy = this.filterLoadedFiles(this.loadSwfsWhenStageCopy);
         this.loadSwfsTotalLen = this.loadSwfsWhenStageCopy.length;
         this.after = func;
         this.checkNext();
      }
      
      private function getRoleAndPetAssets() : Array
      {
         var pi:* = null;
         var petName:* = null;
         var petSwfName:* = null;
         var returnArray:Array = [];
         var role1Name:String = gc.getRoleSwfNameByRoleName("Role1");
         var role2Name:String = gc.getRoleSwfNameByRoleName("Role2");
         var role3Name:String = gc.getRoleSwfNameByRoleName("Role3");
         var role4Name:String = gc.getRoleSwfNameByRoleName("Role4");
         if(gc.curStageAndCurLevel.curStage == 0 || gc.curStageAndCurLevel.curStage == 13 || gc.curStageAndCurLevel.curStage == 42 || gc.curStageAndCurLevel.curStage == 22)
         {
            returnArray.push(role1Name,role2Name,role3Name,role4Name);
         }
         else
         {
            if(gc.player1.roleid > 0 && gc.player1.roleid <= 4)
            {
               returnArray.push(gc.getRoleSwfNameByRoleName("Role" + gc.player1.roleid));
            }
            if(gc.player2.roleid > 0 && gc.player2.roleid <= 4)
            {
               returnArray.push(gc.getRoleSwfNameByRoleName("Role" + gc.player2.roleid));
            }
            if(gc.player3.roleid > 0 && gc.player3.roleid <= 4)
            {
               returnArray.push(gc.getRoleSwfNameByRoleName("Role" + gc.player3.roleid));
            }
            if(PlayerDatasControllor.getIns().playerDatas.length > 0)
            {
               for each(var pl in PlayerDatasControllor.getIns().playerDatas)
               {
                  if(int(pl.data.uid) != GameConst.UID)
                  {
                     if(pl.data.roleid != gc.player1.roleid)
                     {
                        returnArray.push(gc.getRoleSwfNameByRoleName("Role" + pl.data.roleid));
                     }
                  }
               }
            }
         }
         if(gc.curStageAndCurLevel.curStage == 4)
         {
            if(gc.curStageAndCurLevel.curLevel == 1)
            {
               if(returnArray.indexOf(role1Name) == -1)
               {
                  returnArray.push(role1Name);
               }
            }
            else if(gc.curStageAndCurLevel.curLevel == 2)
            {
               if(returnArray.indexOf(role2Name) == -1)
               {
                  returnArray.push(role2Name);
               }
            }
            else if(gc.curStageAndCurLevel.curLevel == 3)
            {
               if(returnArray.indexOf(role3Name) == -1)
               {
                  returnArray.push(role3Name);
               }
            }
            else if(gc.curStageAndCurLevel.curLevel == 4)
            {
               if(returnArray.indexOf(role4Name) == -1)
               {
                  returnArray.push(role4Name);
               }
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 44)
         {
            if(gc.curStageAndCurLevel.curLevel == 2)
            {
               if(returnArray.indexOf(role4Name) == -1)
               {
                  returnArray.push(role4Name);
               }
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 60)
         {
            if(returnArray.indexOf(role1Name) == -1)
            {
               returnArray.push(role1Name);
            }
            if(returnArray.indexOf(role2Name) == -1)
            {
               returnArray.push(role2Name);
            }
            if(returnArray.indexOf(role3Name) == -1)
            {
               returnArray.push(role3Name);
            }
            if(returnArray.indexOf(role4Name) == -1)
            {
               returnArray.push(role4Name);
            }
         }
         if(gc.player1.roleid > 0)
         {
            pi = gc.player1.findCurrentPet(true);
            if(pi)
            {
               petName = pi.getPetPreName();
               petSwfName = gc.getPetSwfNameByPetName(petName);
               if(returnArray.indexOf(petSwfName) == -1)
               {
                  returnArray.push(petSwfName);
               }
            }
         }
         if(gc.player2.roleid > 0)
         {
            pi = gc.player2.findCurrentPet(true);
            if(pi)
            {
               petName = pi.getPetPreName();
               petSwfName = gc.getPetSwfNameByPetName(petName);
               if(returnArray.indexOf(petSwfName) == -1)
               {
                  returnArray.push(petSwfName);
               }
            }
         }
         if(gc.player3.roleid > 0)
         {
            pi = gc.player3.findCurrentPet(true);
            if(pi)
            {
               petName = pi.getPetPreName();
               petSwfName = gc.getPetSwfNameByPetName(petName);
               if(returnArray.indexOf(petSwfName) == -1)
               {
                  returnArray.push(petSwfName);
               }
            }
         }
         if(gc.curStageAndCurLevel.curStage == 57)
         {
            petSwfName = gc.getPetSwfNameByPetName("nian");
            if(returnArray.indexOf(petSwfName) == -1)
            {
               returnArray.push(petSwfName);
            }
         }
         if(gc.curStageAndCurLevel.curStage == 5)
         {
            petSwfName = gc.getPetSwfNameByPetName("monkey");
            if(returnArray.indexOf(petSwfName) == -1)
            {
               returnArray.push(petSwfName);
            }
         }
         if(gc.curStageAndCurLevel.curStage == 6)
         {
            petSwfName = gc.getPetSwfNameByPetName("horse");
            if(returnArray.indexOf(petSwfName) == -1)
            {
               returnArray.push(petSwfName);
            }
         }
         if(gc.curStageAndCurLevel.curStage == 9 || gc.curStageAndCurLevel.curStage == 46)
         {
            petSwfName = gc.getPetSwfNameByPetName("tigress");
            if(returnArray.indexOf(petSwfName) == -1)
            {
               returnArray.push(petSwfName);
            }
         }
         if(gc.curStageAndCurLevel.curStage == 10 || gc.curStageAndCurLevel.curStage == 46)
         {
            petSwfName = gc.getPetSwfNameByPetName("turtle");
            if(returnArray.indexOf(petSwfName) == -1)
            {
               returnArray.push(petSwfName);
            }
         }
         if(gc.curStageAndCurLevel.curStage == 14 || gc.curStageAndCurLevel.curStage == 46)
         {
            petSwfName = gc.getPetSwfNameByPetName("phoenix");
            if(returnArray.indexOf(petSwfName) == -1)
            {
               returnArray.push(petSwfName);
            }
         }
         if(gc.curStageAndCurLevel.curStage == 17)
         {
            petSwfName = gc.getPetSwfNameByPetName("dragon");
            if(returnArray.indexOf(petSwfName) == -1)
            {
               returnArray.push(petSwfName);
            }
         }
         if(gc.curStageAndCurLevel.curStage == 46)
         {
            petSwfName = gc.getPetSwfNameByPetName("rabbit");
            if(returnArray.indexOf(petSwfName) == -1)
            {
               returnArray.push(petSwfName);
            }
         }
         if(gc.curStageAndCurLevel.curStage == 47)
         {
            petSwfName = gc.getPetSwfNameByPetName("nian");
            if(returnArray.indexOf(petSwfName) == -1)
            {
               returnArray.push(petSwfName);
            }
         }
         returnArray.push("petsUniversalv690");
         return returnArray;
      }
      
      private function filterLoadedFiles(arr:Array) : Array
      {
         var returnArray:Array = [];
         for each(var str in arr)
         {
            trace("等待加载的文件:" + str);
            if(!AssetsManager.getInstance().contains(str + ".swf"))
            {
               trace("还没加载过:" + str);
               returnArray.push(str);
            }
            else
            {
               trace("已经加载过:" + str);
            }
         }
         return returnArray;
      }
      
      private function loadSwfByName(name:String, func:Function) : void
      {
         trace("loadSwfByName:" + name);
         this.after = func;
         this.afterName = name;
         uloader = new URLLoader();
         uloader.dataFormat = "binary";
         uloader.addEventListener("complete",this.loadCompleteHandler);
         var url:String = this.getUrlByAfterName() + ".swf";
         uloader.load(new URLRequest(url));
         uloader.addEventListener("ioError",this.IoErrorHandler,false,0,true);
         uloader.addEventListener("progress",this.loadByStageAndLevelProgress);
         var len:uint = this.loadSwfsWhenStageCopy.length;
         GMain.getInstance().showLoadByStageAndLevelProgress(0,len,this.loadSwfsTotalLen);
      }
      
      private function IoErrorHandler(evt:IOErrorEvent) : void
      {
         var l:* = null;
         var url:* = null;
         if(retryTimes > 0)
         {
            l = evt.currentTarget as URLLoader;
            url = this.getUrlByAfterName() + ".swf";
            l.load(new URLRequest(url));
            retryTimes--;
         }
         else
         {
            trace("素材加载错误:" + this.getUrlByAfterName() + ".swf");
         }
      }
      
      private function getUrlByAfterName() : String
      {
         var urlString:String = this.afterName;
         if(urlString == "0")
         {
            urlString = "0v1150";
         }
         if(urlString == "3")
         {
            urlString = "3v690";
         }
         if(urlString == "4")
         {
            urlString = "4v1070";
         }
         if(urlString == "9")
         {
            urlString = "9v680";
         }
         if(urlString == "10")
         {
            urlString = "10v960";
         }
         if(urlString == "11")
         {
            urlString = "11_1";
         }
         if(urlString == "12")
         {
            urlString = "12_2";
         }
         if(urlString == "13")
         {
            urlString = "13v760";
         }
         if(urlString == "14")
         {
            urlString = "14v960";
         }
         if(urlString == "15")
         {
            urlString = "15v680";
         }
         if(urlString == "17")
         {
            urlString = "17_2";
         }
         if(urlString == "21")
         {
            urlString = "21v680";
         }
         if(urlString == "22")
         {
            urlString = "22v680";
         }
         if(urlString == "23")
         {
            urlString = "23v1110";
         }
         if(urlString == "24")
         {
            urlString = "24v1180";
         }
         if(urlString == "25")
         {
            urlString = "25v1310";
         }
         if(urlString == "40")
         {
            urlString = "40v680";
         }
         if(urlString == "41")
         {
            urlString = "41v3651";
         }
         if(urlString == "42")
         {
            urlString = "42v680";
         }
         if(urlString == "44")
         {
            urlString = "44_2";
         }
         if(urlString == "47")
         {
            urlString = "47v680";
         }
         if(urlString == "48")
         {
            urlString = "48v680";
         }
         if(urlString == "50")
         {
            urlString = "50v8201";
         }
         if(urlString == "53")
         {
            urlString = "53v800";
         }
         if(urlString == "54")
         {
            urlString = "54v840";
         }
         if(urlString == "55")
         {
            urlString = "55v880";
         }
         if(urlString == "56")
         {
            urlString = "56v960";
         }
         return urlString;
      }
      
      private function loadCompleteHandler(evt:Event) : void
      {
         var _local4:* = null;
         trace("加载完成：" + this.afterName);
         AssetsManager.getInstance().addAssetsName(this.afterName + ".swf");
         uloader.removeEventListener("complete",arguments.callee);
         var _local3:ByteArray = uloader.data as ByteArray;
         var _local5:Loader = new Loader();
         _local5.contentLoaderInfo.addEventListener("complete",__loadToLocalComplete);
         if(this.whichSwfDontNeedDecrypt(this.afterName))
         {
            _local5.loadBytes(_local3,new LoaderContext(false,ApplicationDomain.currentDomain));
         }
         else
         {
            _local4 = new ByteArray();
            _local4.writeBytes(_local3,300,25);
            _local4.writeBytes(_local3,0,300);
            _local4.writeBytes(_local3,325);
            _local5.loadBytes(_local4,new LoaderContext(false,ApplicationDomain.currentDomain));
         }
         uloader.removeEventListener("progress",loadByStageAndLevelProgress);
         uloader.close();
         uloader = null;
      }
      
      private function whichSwfDontNeedDecrypt(name:String) : Boolean
      {
         if(name.indexOf("Role1") != -1 || name.indexOf("Role2") != -1 || name.indexOf("Role3") != -1 || name.indexOf("Role4") != -1 || name.indexOf("nian") != -1 || name.indexOf("monkey") != -1 || name.indexOf("horse") != -1 || name.indexOf("roomhorse") != -1 || name.indexOf("tigress") != -1 || name.indexOf("turtle") != -1 || name.indexOf("phoenix") != -1 || name.indexOf("dragon") != -1 || name.indexOf("rabbit") != -1 || name.indexOf("ufo") != -1 || name.indexOf("yintiger") != -1 || name.indexOf("petsUniversal") != -1 || name.indexOf("mouse") != -1 || name.indexOf("neat") != -1 || name.indexOf("Monster") != -1 || name == "41")
         {
            return true;
         }
         return false;
      }
      
      protected function __loadToLocalComplete(evt:Event) : void
      {
         var load:LoaderInfo = evt.target as LoaderInfo;
         load.loader.unload();
         this.checkNext();
      }
      
      private function checkNext() : void
      {
         var str:* = null;
         try
         {
            trace("miss:" + AUtils.getNewObj("miss"));
            trace("文件：" + this.afterName);
         }
         catch(e:*)
         {
            trace("没找到:miss");
         }
         if(this.loadSwfsWhenStageCopy.length > 0)
         {
            str = this.loadSwfsWhenStageCopy.shift();
            trace("加载新素材:" + str + ".swf");
            this.loadSwfByName(str,this.after);
         }
         else
         {
            GMain.getInstance().processComplete();
            after();
         }
      }
      
      private function loadByStageAndLevelProgress(evt:ProgressEvent) : void
      {
         var _local2:int = int(evt.bytesLoaded / evt.bytesTotal * 100);
         var len:uint = this.loadSwfsWhenStageCopy.length;
         GMain.getInstance().showLoadByStageAndLevelProgress(_local2,len,this.loadSwfsTotalLen);
      }
   }
}

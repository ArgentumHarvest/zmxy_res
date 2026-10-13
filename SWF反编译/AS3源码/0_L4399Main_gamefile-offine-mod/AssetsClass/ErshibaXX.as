package AssetsClass
{
   import export.animalarray.FourMarixInterface;
   import export.constellations.TwelveConstellations;
   
   public class ErshibaXX extends BaseAssets
   {
       
      
      private var fmi:FourMarixInterface;
      
      public function ErshibaXX()
      {
         super(TwelveConstellations);
         this.loadAssets(["28xx.swf"]);
      }
   }
}

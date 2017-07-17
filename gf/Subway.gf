abstract Subway = {

flags startcat = Order ;
cat 
  Order ;
  Item ;
  [Item] ;
  Number ;
  Size ;
  SubwayNumber ;
  SubwaySize ;
  Fillings ;
  Filling ;
  [Filling]{1};
  DrinkNumber ;
  DrinkSize ;
  DrinkType ;

fun 
  order : [Item] -> Order ;
  subway : SubwayNumber -> SubwaySize -> Fillings -> Item ;
  drink : DrinkNumber -> DrinkSize -> DrinkType -> Item ;

fun
  subwayNumber : Number -> SubwayNumber ;
  drinkNumber : Number -> DrinkNumber ;

fun 
  num_1 : Number ;
  num_2 : Number ;
  num_3 : Number ;
  num_4 : Number ;
  num_5 : Number ;

fun
  subwaySize : Size -> SubwaySize ;
  drinkSize : Size -> DrinkSize ;

fun
  small : Size ;
  large : Size ;

fun 
  fillings : [Filling] -> Fillings ;

fun 
  cheese : Filling ;
  ham : Filling ;
  tuna : Filling ;
  bacon : Filling ;
  chicken : Filling ;

fun 
  coke : DrinkType ;
  beer : DrinkType ;
  

cat
  Output ;

fun
  confirm : [Item] -> Output ;

}

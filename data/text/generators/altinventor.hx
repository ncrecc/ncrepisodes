usestandardenemies();

function isenemyindungeon(enemyname){
  var enemylist = getenemylistindungeon();
  if(enemylist.indexOf(enemyname) == -1) return false;
  return true;
}

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

trace("starting....");

//Floor 1:
var basics = ["Switchblade@even", "Bone Club", "Technology", "Magic Cyanide"];
shuffle(basics);
var scraplist = ["Scrap Slingshot", "Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Lamp", "Scrap Crystal", "Scraptula", "Scrap Slam"];
scraplist = shuffle(scraplist);

items = [basics.pop(), rand(["Scrap Slingshot", "Scrap Crystal", "Scrap Lamp", "Scrapsies"])];
gooditems = [pick(["Uberbump", "Slim Jim", "Welder"])];
otherstuff = [];
goodotherstuff = [];
if(chance(6.25)) { items[1] = "Zombo"; }
else { scraplist.remove(items[1]); }

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
trace("floor 1 done");

//Floor 2:
var spearswing = pick(["Spearhead", "Swing Me Another 6"]);

var brgimmicks = ["Under Pressure", "Whipcrack", "Undermine", "Suspense"];
shuffle(brgimmicks);
var whips = ["Hamment@I", "Hamment@S", "Whisp@W", "Whisp@F"];
shuffle(whips);

function cleanwhips(x,y) {
	switch (x) {
		case "Hamment@I":
			y.remove("Hamment@S");
		case "Hamment@S":
			y.remove("Hamment@S");
		case "Whisp@W":
			y.remove("Whisp@F");
		case "Whisp@F":
			y.remove("Whisp@W");
	} trace("hi");
};

var gimmickorwhip = rand([0|1]);

var gimmickwhipgiven = false;

var shielddrops = shuffle(["Industrial Press", "Defense Mechanism", "Rickety Shield"]);  

var commonlist1 = ["Bumper Sticker", "Hourglass", spearswing, "Sharp Straw", basics.pop(), "Icebox", "Ice Nine", "Sacrificial Blade@3", pick(["Berlin[comma] Massachusetts Key", "Table Flip"]), "Cubby", "Broadkunai"];
if(chance(20)) { commonlist1.remove("Ice Nine"); commonlist1.push("PyrotechnIX"); } //good pun
if(gimmickorwhip == 1) { commonlist1.push(whips.pop()); cleanwhips(commonlist1[commonlist1.length - 1], whips); }
else { commonlist1.push(brgimmicks.pop()); }

var shoplist1 = ["Power Glove", "Crush Together", "Survivor's Guilt", "Radio Dial", "Autohook", "Virtue Grip", basics.pop(), "Lightstick", "No Pain No Gain", "Berliner", "Tragic Entrance", "Buzzsaw", "Smartwatch", "Bronze Dagger", "Wail Bat", "Crazy Glue", "Generous Crystal"];
if (chance(30)) shoplist1.push("Warhammer");
if (chance(30)) shoplist1.push("Mo' Money Mo' Problems");
commonlist1 = shuffle(commonlist1);
shoplist1 = shuffle(shoplist1);

items = [];
if(chance(20)) items.push(commonlist1.pop());
gooditems = [commonlist1.pop(), chance(30) ? shielddrops.pop() : commonlist1.pop()];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop(shuffle(["upgrade", shoplist1.pop(), shoplist1.pop()]), shuffle([2, 3, 4]))
];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

trace("floor 2 done");

//Floor 3:

scraplist.push("Four Movable Steel Plates");
shuffle(scraplist);

if(gimmickorwhip == 1 && commonlist1.indexOf("Hamment@I") == -1 && commonlist1.indexOf("Hamment@S") == -1 && commonlist1.indexOf("Whisp@F") == -1 && commonlist1.indexOf("Whisp@W") == -1) { gimmickwhipgiven = true; } //aaaaaaaaaaaaaaaaaaaaaaaaaaaa there has to be a better way to do this
if(gimmickorwhip == 0 && commonlist1.indexOf("Under Pressure") == -1 && commonlist1.indexOf("Whipcrack") == -1 && commonlist1.indexOf("Undermine") == -1) { gimmickwhipgiven = true; }

var midtierdrops = shuffle(["Gadsby Gun", "Technology", "Chainsmoke", rand(["Keyhole","Stockpick"]), "Gas Lamp", "Operator", "Sucker Punch", "Hush", "Shudder", "Veneer"]);
if(chance(33)) { midtierdrops.push(rand(["Charity", "Humility"])); }
if(chance(33)) { midtierdrops.push(rand(["Greed", "Envy"])); }
items = [rand(["Scrap Trap", "Scrapsies", "Scrapstick", "Scrap Slam"])];
scraplist.remove(items[0]);
items.push(chance(17.5) ? shielddrops.pop() : pick(["Kale Smoothie", "Starspear", "Biohazard"]));
gooditems = [midtierdrops.pop()];
		
var includewhipgimmick = [];
if(gimmickwhipgiven == false) {
if(gimmickorwhip == 1) {
includewhipgimmick.push(whips.pop());
cleanwhips(includewhipgimmick[0],whips);
} else {
includewhipgimmick.push(brgimmicks.pop());
} }

shoplist1.pop();
shoplist1.pop();
shoplist1.push("Compact Resonator");
shoplist1.push("Binoculars");
shuffle(shoplist1);

var commonlist2 = ["Marshmallow Fluff", "Gravity", "Vantablack", "Roman Candle@ncrmod", "Healer Staff", "Gizmotron", "Gag Rule", "Two Handed Spatula", "Cremator", "Sheer Will", "Queen of Diamonds", "Revolver@ncrmod", "Tear Down This Wall", "Vanity Mirror", "Starspear", "Innovate", "Gyrate Hook", "Junk Sword", "Bumpbomb", "Heat Pump", scraplist.pop()];
if(chance(30)) commonlist2.push("Dripping Yellow Madness");

if(includewhipgimmick.length > 0) { commonlist2.push(includewhipgimmick.pop()); }
commonlist2.push(pick(["Hunting Knife@small", "Hunting Knife@large"]));
if (chance(20)) commonlist2.push("Glassblowing");
if (chance(30)) { commonlist2.push("Velocity"); commonlist2.push("Platinum Blade"); }
if (chance(10)) { commonlist2.push("Cybernetics"); }
shuffle(commonlist2);

otherstuff = [health()];
goodotherstuff = [
  shop(shuffle([shoplist1.pop(), shoplist1.pop(), commonlist1.pop()]), shuffle([1, 2, 3])),
  shop(shuffle([commonlist2.pop(), chance(30) ? shielddrops.pop() : commonlist1.pop(), "upgrade"]))
];
	
addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
trace("floor 3 done");
  
//Floor 4:

var zombobmoz = false;

if(chance(2)) { zombobmoz = true; }

if(zombobmoz != true) {
	items = [pick([commonlist2.pop(), commonlist2.pop(), "Third Place Cauldron"])];
}
else {
	items = [pick(["Zombocom", "Obmozcom"])];
}

gooditems = [midtierdrops.pop()];

otherstuff = [health(), health()];
goodotherstuff = [];
		
addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
  
trace("floor 4 done");
  
//Floor 5:
items = [pick([brgimmicks.pop(), "Hot Table", "Mirrorang", "Baby's First Counting Book"]), scraplist.pop()];
gooditems = [pick([midtierdrops.pop(), commonlist2.pop()])];
		
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([commonlist2.pop(), "health", commonlist1.pop()])),
  upgrade()
];
		
addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
  
trace("floor 5 done");

//Floor 6:
items = [];
gooditems = [];
otherstuff = [];
goodotherstuff = [];

var lastfloor = addfloor("boss");

if (getfinalboss() == "Drake"){
  items.push("Silver Sword");
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
		
trace("last floor done");
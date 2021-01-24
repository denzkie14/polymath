import 'package:polymath/components/bubble.dart';
import 'package:polymath/popme.dart';

class BubbleSpawner {
final PopMe game;

final int maxSpawnInterval = 500;
final int minSpawnInterval = 250;
final int intervalChange = 1;
final int maxFliesOnScreen = 10;

int currentInterval;
int nextSpawn;

BubbleSpawner(this.game) {
start();
game.spawnFly();
  }

 void start() {
  
  killAll();
  game.questionIndex=0;
  game.currentQuestion=0;
  currentInterval = maxSpawnInterval;
  nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
}


  void killAll() {
   
    game.flies.forEach((Bubble fly) => fly.isDead = true);
    
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

int livingFlies = 0;
game.flies.forEach((Bubble fly) {
  if (!fly.isDead) livingFlies += 1;
});

if (nowTimestamp >= nextSpawn && (livingFlies < maxFliesOnScreen)) {
  game.questionIndex++;
   //game.currentQuestion++;
  game.spawnFly();
  if (currentInterval > minSpawnInterval) {
    currentInterval -= intervalChange;
    currentInterval -= (currentInterval * .02).toInt();
  }
  nextSpawn = nowTimestamp + currentInterval;
  
}
  }
}
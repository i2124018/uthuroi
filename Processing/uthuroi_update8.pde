import processing.serial.*;

Serial myPort;
int[] serialInArray = new int[1];

int serialCount = 0;
int Val;
int ARD;

boolean firstContact = false;

PImage img;

// spNumXY  Xは花の咲く場所（1-5)、Yは各場所での色が違う(1-4)
int spNum1;
int spNum12;
int spNum13;
int spNum14;
int spNum2;
int spNum22;
int spNum23;
int spNum24;
int spNum3;
int spNum32;
int spNum33;
int spNum34;
int spNum4;
int spNum42;
int spNum43;
int spNum44;
int spNum5;
int spNum52;
int spNum53;
int spNum54;

int counts = 1; //季節管理
int PP = 0;     //
int Pin = 0;    //0だと花が大きくなり、1だと小さくなる

float R1 = 0, G1 = 0, B1 = 0;
float R2 = 0, R3 = 0, R4 = 0, G2 = 0, G3 = 0, G4 = 0, B2 = 0, B3 = 0, B4 = 0;

// クラス定義
Sakura[] sp1;  //左の花
Sakura2[] sp12;
Sakura3[] sp13;
Sakura4[] sp14;
Sakura[] sp2;
Sakura2[] sp22;
Sakura3[] sp23;
Sakura4[] sp24;
Sakura[] sp3;    //右下の花
Sakura2[] sp32;
Sakura3[] sp33;
Sakura4[] sp34;
Sakura[] sp4;
Sakura2[] sp42;
Sakura3[] sp43;
Sakura4[] sp44;
Sakura[] sp5;
Sakura2[] sp52;
Sakura3[] sp53;
Sakura4[] sp54;


void setup() {
  //size(720, 480);
  fullScreen();


  println(Serial.list());
  
  //Arduinoとのシリアル通信
  String portName = Serial.list()[1];
  myPort = new Serial(this, "/dev/tty.usbmodem1101", 9600);
}


void draw() {
  Takashi();
  background(255);
  fill(0);

  for (int i = 0; i < spNum1; i++) {
    sp1[i].run();
  }
  for (int i = 0; i < spNum12; i++) {
    sp12[i].run();
  }
  for (int i = 0; i < spNum13; i++) {
    sp13[i].run();
  }
  for (int i = 0; i < spNum14; i++) {
    sp14[i].run();
  }

  for (int i = 0; i < spNum2; i++) {
    sp2[i].run();
  }
  for (int i = 0; i < spNum22; i++) {
    sp22[i].run();
  }
  for (int i = 0; i < spNum23; i++) {
    sp23[i].run();
  }
  for (int i = 0; i < spNum24; i++) {
    sp24[i].run();
  }

  for (int i = 0; i < spNum3; i++) {
    sp3[i].run();
  }
  for (int i = 0; i < spNum32; i++) {
    sp32[i].run();
  }
  for (int i = 0; i < spNum33; i++) {
    sp33[i].run();
  }
  for (int i = 0; i < spNum34; i++) {
    sp34[i].run();
  }

  for (int i = 0; i < spNum4; i++) {
    sp4[i].run();
  }
  for (int i = 0; i < spNum42; i++) {
    sp42[i].run();
  }
  for (int i = 0; i < spNum43; i++) {
    sp43[i].run();
  }
  for (int i = 0; i < spNum44; i++) {
    sp44[i].run();
  }

  for (int i = 0; i < spNum5; i++) {
    sp5[i].run();
  }
  for (int i = 0; i < spNum52; i++) {
    sp52[i].run();
  }
  for (int i = 0; i < spNum53; i++) {
    sp53[i].run();
  }
  for (int i = 0; i < spNum54; i++) {
    sp54[i].run();
  }
  
  fill(0);
  quad(0, 0, 454, 0 , 454, 170, 0, 170);
  quad(0, height - 205, 450, height - 190, 450, height, 0, height);
  quad(width - 460, 0, width, 0, width, 175, width - 460, 185);
  quad(width - 465, height - 190, width, height - 200, width, height, width - 465, height);
   fill(255);
  text(PP, 10, 30);
  text(ARD, 40, 30);
  text(Val, 60, 30);
}
    

void Takashi() {   //花の詳細
  float Dis = 0.1;
  float r, centerX, centerY;

  //季節の切り替え　
  //ARD=Arduinoからのデータ(季節が進むごとに24を引くことで花の大きさをリセットしている)
  //counts =  季節を管理　1から順に春夏秋
  //Pin = 花の開きを管理。0だと開いて大きくなる、1だと散って小さくなる
  if(0 <= Val && Val <= 23){   //春の開花
    ARD = Val;
    counts = 1;
    Pin = 0;
  }else if(23 < Val && Val  <= 47){    //春の散花
    ARD = Val - 24;
    counts = 1;
    Pin = 1;
  }else if(47 < Val && Val <= 71){    //夏
    ARD = Val -48;
    counts = 2;
    Pin = 0;
  }else if(71 < Val && Val <= 95){   //紅葉
    ARD = Val - 72;
    counts = 2;
    Pin = 2;
  }else if(95 < Val && Val <= 119){    //落葉
    ARD = Val -96;
    counts = 3;
    Pin = 1;
  }else if(119 < Val && Val <= 143){    //冬
    ARD = Val - 120;
    Pin = 3;
  }
  
  if(Val == 48 || Val == 0){    //春から夏への花の再生成
    PP = 0;
  }
  

  if (PP == 0) {
    int R1 = 0, G1 = 0, B1 = 0;
    int R2 = 0, R3 = 0, R4 = 0, G2 = 0, G3 = 0, G4 = 0, B2 = 0, B3 = 0, B4 = 0;


    spNum1 = 200;   //各箇所の花の数
    spNum12 =175;
    spNum13 = 100;
    spNum14 = 32;
    spNum2 = 84;
    spNum22 = 32;
    spNum23 = 32;
    spNum24 = 10;
    spNum3 = 64;
    spNum32 = 32;
    spNum33 = 32;
    spNum34 = 10;
    spNum4 = 128;
    spNum42 = 64;
    spNum43 = 64;
    spNum44 = 25;
    spNum5 = 150;
    spNum52 = 64;
    spNum53 = 32;
    spNum54 = 10;
    
    sp1 = new Sakura[spNum1];      //クラス生成
    sp12 = new Sakura2[spNum12];
    sp13 = new Sakura3[spNum13];
    sp14 = new Sakura4[spNum14];
    sp2 = new Sakura[spNum2];
    sp22 = new Sakura2[spNum22];
    sp23 = new Sakura3[spNum23];
    sp24 = new Sakura4[spNum24];
    sp3 = new Sakura[spNum3];
    sp32 = new Sakura2[spNum32];
    sp33 = new Sakura3[spNum33];
    sp34 = new Sakura4[spNum34];
    sp4 = new Sakura[spNum4];
    sp42 = new Sakura2[spNum42];
    sp43 = new Sakura3[spNum43];
    sp44 = new Sakura4[spNum44];
    sp5 = new Sakura[spNum5];
    sp52 = new Sakura2[spNum52];
    sp53 = new Sakura3[spNum53];
    sp54 = new Sakura4[spNum54];


    // 花の設定
    //一番左の花
    r = 240; // 花の開く範囲
    centerX = width/7;          //開く範囲の中央のX座標
    centerY = height*10/20;     //開く範囲の中央のY座標
    for (int i = 0; i < spNum1; i++) {  //花のランダム生成
      float angle = random(TWO_PI);    //360度の範囲でランダム
      float h = sqrt(random(1));       //中央からの距離定数
      float tempX = centerX + h * r * cos(angle);  //中央座標から半径と角度、距離定数でランダムで設定
      float tempY = centerY + h * r * sin(angle);
      sp1[i] = new Sakura(tempX, tempY, Dis, random(5, 20), R1, G1, B1, 100); //生成
    }

    for (int i = 0; i < spNum12; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
          sp12[i] = new Sakura2(tempX, tempY, Dis, random(3, 15), R2, G2, B2, 180);
    }

    for (int i = 0; i < spNum13; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp13[i] = new Sakura3(tempX, tempY, Dis, random(3, 15), R3, G3, B3, 100);
    }

    for (int i = 0; i < spNum14; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp14[i] = new Sakura4(tempX, tempY, Dis, random(3, 15), R4, G4, B4, 100);
    }


    r = 130;
    centerX = 1200;
    centerY = 250;
    for (int i = 0; i < spNum2; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp2[i] = new Sakura(tempX, tempY, Dis, random(3, 15), R1, G1, B1, 100);
    }
    for (int i = 0; i < spNum22; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp22[i] = new Sakura2(tempX, tempY, Dis, random(3, 15), R2, G2, B2, 180);
    }
    for (int i = 0; i < spNum23; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp23[i] = new Sakura3(tempX, tempY, Dis, random(3, 15), R3, G3, B3, 100);
    }
    for (int i = 0; i < spNum24; i++) {
     float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp24[i] = new Sakura4(tempX, tempY, Dis, random(3, 15), R4, G4, B4, 100);
    }

    r = 135;
    centerX = 1150;
    centerY = 470;
    for (int i = 0; i < spNum3; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp3[i] = new Sakura(tempX, tempY, Dis, random(5, 20), R1, G1, B1, 100);
    }
    for (int i = 0; i < spNum32; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp32[i] = new Sakura2(tempX, tempY, Dis, random(3, 15), R2, G2, B2, 180);
    }
    for (int i = 0; i < spNum33; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp33[i] = new Sakura3(tempX, tempY, Dis, random(3, 15), R3, G3, B3, 100);
    }
    for (int i = 0; i < spNum34; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp34[i] = new Sakura4(tempX, tempY, Dis, random(3, 15), R4, G4, B4, 100);
    }

    r = 170;
    centerX = 620;
    centerY = 230;
    for (int i = 0; i < spNum4; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp4[i] = new Sakura(tempX, tempY, Dis, random(5, 20), R1, G1, B1, 100);
    }
    for (int i = 0; i < spNum42; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp42[i] = new Sakura2(tempX, tempY, Dis, random(3, 15), R2, G2, B2, 180);
    }
    for (int i = 0; i < spNum43; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp43[i] = new Sakura3(tempX, tempY, Dis, random(3, 15), R3, G3, B3, 100);
    }
    for (int i = 0; i < spNum44; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp44[i] = new Sakura4(tempX, tempY, Dis, random(3, 15), R4, G4, B4, 100);
    }

    r = 150;
    centerX = 900;
    centerY = 200;
    for (int i = 0; i < spNum5; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp5[i] = new Sakura(tempX, tempY, Dis, random(5, 20), R1, G1, B1, 100);
    }
    for (int i = 0; i < spNum52; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp52[i] = new Sakura2(tempX, tempY, Dis, random(3, 15), R2, G2, B2, 180);
    }
    for (int i = 0; i < spNum53; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp53[i] = new Sakura3(tempX, tempY, Dis, random(3, 15), R3, G3, B3, 100);
    }
    for (int i = 0; i < spNum54; i++) {
      float angle = random(TWO_PI);
      float h = sqrt(random(1));
      float tempX = centerX + h * r * cos(angle);
      float tempY = centerY + h * r * sin(angle);
      sp54[i] = new Sakura4(tempX, tempY, Dis, random(3, 15), R4, G4, B4, 100);
    }

    PP ++;
  }
}

void keyPressed() {
  if (key == 'k') {   // リセット
    counts = 1;
    Pin = 0;
    PP = 0;
  }
}


void serialEvent(Serial myPort) { //シリアル通信
  int inByte = myPort.read();

  if (firstContact == false) {   //シリアル通信　で　A　という文字を受け取ったら値を受け取る
    if (inByte == 'A') {
      myPort.clear();
      firstContact = true;
      myPort.write('A');
    }
  } else {
    serialInArray[serialCount] = inByte;
    serialCount++;

    // もし 3 バイトが入ってきたら:
    if (serialCount > 0 ) {
      Val = serialInArray[0];　//Arduinoからの数値


      myPort.write('A');

      serialCount = 0;
    }
  }
}


int Max_val = 24;

//色が各季節で4種類あるため、4つのクラスを作成
class Sakura {
  float d, x, y, max, r, g, b, o;

  Sakura(float _x, float _y, float _d, float _max, float _r, float _g, float _b, float _o) {
    x = _x;  //x座標
    y = _y;  //y座標
    d = _d;  //半径
    max = _max;    //半径の上限値
    r = _r;      // 色指定(r,g,b)
    g = _g;
    b = _b;
    o = _o;     //透明度
  }

  void run() {
    display();
  }

  void display() {   //花一輪の設定
    noStroke();
    fill(r, g, b, o);
    ellipse(x, y, d, d);
    float Flower_size = map(ARD, 0, Max_val, 0, max);
    o = 100;
    
    switch(counts){ //カラー設定　1＝春　2＝夏　3＝秋
      case 1:
        r = 255;
        g = 140;
        b = 190;
        break;
      case 2:
        r = 154;
        g = 206;
        b = 132;
        break;
      case 3:
        r = 255;
        g = 113;
        b = 64;
        break;
    }
    
    switch(Pin){ //花の開花、散花
    case 0:     //開花
      if(Flower_size <= max) {   //半径が上限になるまで
        d = Flower_size;
      } else{       //上限になったら維持
        d = max;
      }
      break;
    case 1:    //散花
      o = map(ARD, 0, 24, 100, 0);
      d = max;
      break;
    case 2:
      d = max;
      r = map(ARD, 0 , Max_val, 154, 255);
      g = map(ARD, 0 , Max_val, 206, 113);
      b = map(ARD, 0 , Max_val, 132, 64);
      break;
    case 3: //描画なし
      o = 0;
      break;
    } 
  }
}


class Sakura2 {
  float d, x, y, max, r, g, b, o;

  Sakura2(float _x, float _y, float _d, float _max, float _r, float _g, float _b, float _o) {
    x = _x;  //x座標
    y = _y;  //y座標
    d = _d;  //半径
    max = _max;    //半径の上限値
    r = _r;      // 色指定(r,g,b)
    g = _g;
    b = _b;
    o = _o;     //透明度
  }

  void run() {
    display();
  }

  void display() {   //花一輪の設定
    noStroke();
    fill(r, g, b, o);
    ellipse(x, y, d, d);

    float Flower_size = map(ARD, 0, Max_val, 0, max);
    o = 180;
    
    switch(counts){
      case 1:
        r = 255;
        g = 212;
        b = 251;
        break;
      case 2:
        r = 122;
        g = 255;
        b = 115;
        break;
      case 3:
        r = 255;
        g = 210;
        b = 110;
        break;
    }
    
    switch(Pin) {
    case 0:      //開花
      if(Flower_size <= max) {   //半径が上限になるまで
        d = Flower_size;
      } else{       //上限になったら維持
        d = max;
      }
      break;
    case 1:    //散花
      o = map(ARD, 0, 24, 100, 0);
      d = max;
      break;
    case 2:
      d = max;
      r = map(ARD, 0 , Max_val, 122, 255);
      g = map(ARD, 0 , Max_val, 255, 210);
      b = map(ARD, 0 , Max_val, 115, 110);
      break;
    case 3:
      o = 0;
      break;
    }
        
  }
}

class Sakura3 {
  float d, x, y, max, r, g, b, o;

  Sakura3(float _x, float _y, float _d, float _max, float _r, float _g, float _b, float _o) {
    x = _x;  //x座標
    y = _y;  //y座標
    d = _d;  //半径
    max = _max;    //半径の上限値
    r = _r;      // 色指定(r,g,b)
    g = _g;
    b = _b;
    o = _o;     //透明度
  }

  void run() {
    display();
  }

  void display() {   //花一輪の設定
    noStroke();
    fill(r, g, b, o);
    ellipse(x, y, d, d);

    float Flower_size = map(ARD, 0, Max_val, 0, max);
    
    o = 100;
    
    switch(counts){//色の変更
      case 1:    //春
        r = 182;
        g = 147;
        b = 226;
        break;
      case 2:    //夏
        r = 71;
        g = 165;
        b = 71;
        break;
      case 3:    //秋
        r = 209;
        g = 50;
        b = 34;
        break;
    }
    
    switch(Pin) {
    case 0:      //開花
      if(Flower_size <= max) {   //半径が上限になるまで
        d = Flower_size;
      } else{       //上限になったら維持
        d = max;
      }
      break;
    case 1:    //散花
      o = map(ARD, 0, 24, 100, 0);
      d = max;
      break;
    case 2:
      d = max;
      r = map(ARD, 0 , Max_val, 71, 209);
      g = map(ARD, 0 , Max_val, 165, 50);
      b = map(ARD, 0 , Max_val, 71, 34);
      break;
    case 3:
      o = 0;
      break;
    }
        
  }
}

class Sakura4 {
  float d, x, y, max, r, g, b, o;

  Sakura4(float _x, float _y, float _d, float _max, float _r, float _g, float _b, float _o) {
    x = _x;  //x座標
    y = _y;  //y座標
    d = _d;  //半径
    max = _max;    //半径の上限値
    r = _r;      // 色指定(r,g,b)
    g = _g;
    b = _b;
    o = _o;     //透明度
  }

  void run() {
    display();
  }

  void display() {   //花一輪の設定
    noStroke();
    fill(r, g, b, o);
    ellipse(x, y, d, d);

    float Flower_size = map(ARD, 0, Max_val, 0, max);
    o = 100;
    
    switch(counts){
      case 1:
        r = 154;
        g = 208;
        b = 219;
        break;
      case 2:
        r = 255;
        g = 226;
        b = 105;
        break;
      case 3:
        r = 242;
        g = 65;
        b = 17;
        break;
    }
    
    switch(Pin) {
    case 0:      //開花
      if(Flower_size <= max) {   //半径が上限になるまで
        d = Flower_size;
      } else{       //上限になったら維持
        d = max;
      }
      break;
    case 1:    //散花
      o = map(ARD, 0, 24, 100, 0);
      d = max;
      break;
    case 2:
      d = max;
      r = map(ARD, 0 , Max_val, 255, 242);
      g = map(ARD, 0 , Max_val, 226, 65);
      b = map(ARD, 0 , Max_val, 105, 17);
      break;
    case 3:
      o = 0;
      break;
    }
        
  }
}

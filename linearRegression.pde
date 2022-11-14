
ArrayList<PVector> data = new ArrayList();

float m = 1; //y = mx^2 + bx+c
float b = 0;
float c = 0;

float xmean = 0;
float ymean = 0;

float rSquareValue = 0;

void setup() {
  size(800, 800);
  background(255);
}


void drawLine() {
  //float xx1 = 0;
  //float xx2 = 1;
  //float yy1 = m*xx1*xx1+ b*xx1+c;
  //float yy2 = m*xx2*xx2+ b*xx2+c;

  //float x1 = map(xx1, 0, 1, 0, width);
  //float y1 = map(yy1, 0, 1, height, 0);
  //float x2 = map(xx2, 0, 1, 0, width);
  //float y2 = map(yy2, 0, 1, height, 0);

  stroke(255, 0, 255);
  //line(x1, y1, x2, y2);
  for(int x = 0; x < 1000; x++){
  float n = norm(x, 0.0, 100);//n 的区间是（0,1）
  float y = m*pow(n, 2)+b*n+c;  //y = n^4
  //y *= 100; //把区间转换到（0， 100）这个y *= 100等价于lerp(0,100,y) 
  point(x, y);//描点画图
}
}

void mousePressed() {
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 1, 0);
  PVector point = new PVector(x, y);
  data.add(point);
}


void linearRegression(){
  float xsum = 0;
  float ysum = 0;
  float xsuqsum=0;
  float xtrisum=0;
  float xcubsum=0;
  float xysum=0;
  float yxsuqsum=0;
  
  for(int i = 0; i < data.size(); i ++){
    xsum = xsum + data.get(i).x;
    ysum = ysum + data.get(i).y;
    xsuqsum = xsuqsum +(data.get(i).x)*(data.get(i).x);
    xtrisum = xtrisum +(data.get(i).x)*(data.get(i).x)*(data.get(i).x);
    xcubsum = xcubsum +(data.get(i).x)*(data.get(i).x)*(data.get(i).x)*(data.get(i).x);
    xysum = xysum+data.get(i).x*data.get(i).y;
    yxsuqsum = yxsuqsum+data.get(i).y*data.get(i).x*data.get(i).x;
  }
  
  xmean = xsum / data.size();
  ymean = ysum / data.size();
  
  //float upperPart = 0;
  //float lowerPart = 0;
  float c0=0;
  float b0=0;
  float m0=0;
  float z1=0;
  float z2=0;
  float z3=0;
  
  for(int i=0; i<data.size();i++){
    //upperPart = upperPart + (data.get(i).x - xmean)*(data.get(i).y - ymean);
    //lowerPart += (data.get(i).x - xmean)*(data.get(i).x - xmean);
    c0=c; 
    c=(ysum-b*xsum-m*xsuqsum)/data.size();
    z1=(c-c0)*(c-c0);
    b0=b;
    b=(xysum-c*xsum-m*xtrisum)/xsuqsum;
    z2=(b-b0)*(b-b0);
    m0=m;
    m=(yxsuqsum-c*xsuqsum-b*xtrisum)/xcubsum;
    z3=(m-m0)*(m-m0);
     
  }
  
  //m = upperPart / lowerPart;
  //b = ymean -m * xmean;
  //c = 1;
}


void gradientDescent(){
  float learningRate = 0.05;
  for(int i = 0; i < data.size(); i ++){
    float x = data.get(i).x;
    float y = data.get(i).y;
    
    float predict = m * x *x+ b*x+c;
    float error = y- predict;
    
    m = m +error * x * learningRate;
    b = b +error * learningRate;
  }
}


//void getMeans(){
  
//}


void rSquare(){
  float ypredictSubYSum = 0;
  float ymeanSquareSum = 0;
  
  for(int i = 0; i < data.size(); i ++){
    float ypredict = m * data.get(i).x *data.get(i).x+ b*data.get(i).x+c;
    //ypredictSubYSum += (data.get(i).y - ypredict)*(data.get(i).y - ypredict);
    ypredictSubYSum += (ymean - ypredict)*(ymean - ypredict);
    ymeanSquareSum += (data.get(i).y - ymean)*(data.get(i).y - ymean);
  }
  
  //rSquareValue = 1 - ypredictSubYSum / ymeanSquareSum;
  rSquareValue = ypredictSubYSum / ymeanSquareSum;
  
}

void draw() {
  background(255);
  drawLine();
  saveFrame();
  for (int i = 0; i < data.size(); i ++) {
    float ex = map(data.get(i).x, 0, 1, 0, width);
    float ey = map(data.get(i).y, 0, 1, height, 0);
    fill(51);
    noStroke();
    ellipse(ex, ey, 10, 10);
  }
  
  //getMeans();
  linearRegression();
  //gradientDescent();
  //rSquare();
  
  fill(0);
  //text("R^2: " + rSquareValue, width-100, 50);
}

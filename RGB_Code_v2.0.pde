import java.util.*;

int nullCharCode = 0;
PImage RGBCode;
String RGBDecode;

void setup() {
    
   String text = join(loadStrings("text.txt"),"\n");
   size(500,500);
 
   RGBCode = encode(text);
    
   RGBDecode = decode(RGBCode);
   
   saveStrings("data/decodedText.txt",split(RGBDecode,"\n"));

}

void draw() {
 
  image(RGBCode,0,0);
  
}


PImage encode(String text){
  
  int textLength = text.length();
   int[] ints = charToInt(textToCharArray(text));
 
   
   int codeSide = findSideLength(textLength);
   int codeArea = (int)sq(codeSide);
   PImage image = createImage(codeSide,codeSide,ARGB);
   print("A code with "+codeSide+"x"+codeSide+" was created.");
   
   image.loadPixels(); 
   
   for(int i = 0; i < textLength;i++){
     
     int currentPixel = i % codeArea;

     if(i < codeArea){
       image.pixels[currentPixel] = color(ints[i],nullCharCode,nullCharCode,nullCharCode);
     }
     else if (i < codeArea*2){
       image.pixels[currentPixel] = color(red(image.pixels[currentPixel]),ints[i],nullCharCode,nullCharCode);
     }
     else if(i < codeArea*3){
       image.pixels[currentPixel] = color(red(image.pixels[currentPixel]),green(image.pixels[currentPixel]),ints[i],nullCharCode);
     }
     else {
       image.pixels[currentPixel] = color(red(image.pixels[currentPixel]),green(image.pixels[currentPixel]),blue(image.pixels[currentPixel]),ints[i]);
     }
}

   image.updatePixels();
   return image;
  
}

String decode(PImage image){
  
  image.loadPixels();
  
  int codeArea = image.pixels.length;
  int usedPixels = 0;
  
  for(int i = 0; i < codeArea;i++){
   
    color c = image.pixels[i];
    
    if(red(c) != nullCharCode) { usedPixels++; };
    if(green(c) != nullCharCode) { usedPixels++; };
    if(blue(c) != nullCharCode) { usedPixels++; };
    if(alpha(c) != nullCharCode) { usedPixels++; };
    
  }
  
  int[] ints = new int[usedPixels];
  
  for(int i = 0; i < usedPixels; i++){
    
    int currentPixel = i % codeArea;
    
    if(i < codeArea){  
      ints[i] = int(red(image.pixels[currentPixel]));
    }
    else if (i < codeArea*2){
      ints[i] = int(green(image.pixels[currentPixel]));
    }
    else if (i < codeArea*3){
      ints[i] = int(blue(image.pixels[currentPixel]));
    }
    else {
      ints[i] = int(alpha(image.pixels[currentPixel]));
    }
  }
  
  return charArrayToString(intToChar(ints));
  
  
}

char[] textToCharArray(String text){
  
  return text.toCharArray();
  
}

String charArrayToString(char[] chars){
 
  return new String(chars);
  
}

int[] charToInt(char[] chars){
 
  int numberOfChars = chars.length;
  int[] ints = new int[numberOfChars];
  
  for(int i =0; i < numberOfChars;i++){
    
    ints[i] = int(chars[i]);
    
  }
  
  return ints;
  
}

char[] intToChar(int[] ints) {
  
  int numberOfInts = ints.length;
  char[] chars = new char[numberOfInts];
  
  for(int i =0; i < numberOfInts;i++){
    
    chars[i] = char(ints[i]);
    
  }
  
  return chars;
  
}

int findSideLength(int chars)
{
  
  return ceil(sqrt(float(chars)/4));
  
    
}
 

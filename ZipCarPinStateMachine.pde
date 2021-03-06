public class ZipCarPinStateMachine{
  PImage imgDigit1;
  PImage imgDigit2;
  PImage imgDigit3;
  PImage imgDigit4;
  PImage imgKeypad;
  
  public boolean authenticated=false;
  private String I1, I2, I3, I4;
  private int pinCount;
  private Pin pin;
  
  //Current State 
  ZipCarPinState pinState;
  
  //Different Pin States
  NoPinDigits digit0;
  OnePinDigit digit1;
  TwoPinDigits digit2;
  ThreePinDigits digit3;
  FourPinDigits digit4;
    
  public ZipCarPinStateMachine(){
    digit0 = new NoPinDigits(this);
    digit1 = new OnePinDigit(this);
    digit2 = new TwoPinDigits(this);
    digit3 = new ThreePinDigits(this);
    digit4 = new FourPinDigits(this);
    this.pin = Pin.getInstance();
    this.pinState=digit0;
    imgKeypad = loadImage("keypad.png");
    imgDigit1 = loadImage("digit1.png");
    imgDigit2 = loadImage("digit2.png");
    imgDigit3 = loadImage("digit3.png");
  }
  
  void setPinState(ZipCarPinState newPinState){
    pinState = newPinState;
  } 
  
  void delete(){
    pinState.delete();
  }
  
  void enterDigit(String inputKey){
    pinState.enterDigit(inputKey);
  }
  
  void validPin() {
    pinState.validPin();
  }
  
  void invalidPin() {
    pinState.invalidPin();    
  }
  
  public ZipCarPinState NoPinDigitState(){
    this.pinCount=0;
    this.I1 = ""; 
    this.I2 = "";
    this.I3 = "";
    this.I4 = "";
    image(imgKeypad, 0, 0, 300, 550);
    pin.setTouchScreenFlag(0);
    return digit0;
  }
    
  public ZipCarPinState OnePinDigitState(String inputKey){ 
    this.pinCount=1;
    if(inputKey != "-")
      this.I1 = inputKey; 
    else 
      this.I2="";
    image(imgDigit1, 0, 0, 300, 550);
    return digit1;
  }
  
  public ZipCarPinState TwoPinDigitsState(String inputKey){ 
    this.pinCount=2;
    if(inputKey != "-")
      this.I2 = inputKey; 
     else 
      this.I3="";
    image(imgDigit2, 0, 0, 300, 550);
    return digit2;
  }
  
  public ZipCarPinState ThreePinDigitsState(String inputKey){ 
    this.pinCount=3;
    if(inputKey != "-")
      this.I3 = inputKey; 
    else 
      this.I4="";
    image(imgDigit3, 0, 0, 300, 550);
    return digit3;
  }
  
  public ZipCarPinState FourPinDigitsState(String inputKey){ 
    this.pinCount=4;
    this.I4 = inputKey;
    String newText = I1+I2+I3+I4;
    System.out.println(newText);
      if(newText.equals("1234")){
        System.out.println("Authenticated");
        this.pin.setAuthentication(true);
        return digit4;
      }
      else {
        return NoPinDigitState();
      }
  }
  
}

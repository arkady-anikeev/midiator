unit NotesData;

interface
uses System.Classes;
const
  NumOfKeys = 128;
  KeyNames : array[1..12] of string[2]=
        ('C ' ,'C#' ,'D ' ,'D#' ,'E ' ,'F ' ,'F#' ,'G' ,'G#' ,'A ' ,'A#' ,'B ' );
  KeyShift : array[1..12] of integer = (0 ,0 ,2,-1 ,4 ,-1 ,-1 , 1,0 ,3 ,0 ,5 );

  BlackKeys =[2,4,7,9,11];

  NumOfMeasures= 100;//1000;
  TicksPerBit=120;
  {2,4,7,9,11}
 type
  TNoteList = Class (TList)
    public
      {public fields}
      {public methods}
    protected
      {protected fields}
      {protected methods}
    private
      {private fields}
      {private methods}
end;
implementation

end.

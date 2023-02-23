
int row = 20;
int col = 15;
int N = row*col;

//Point masses
PVector[] x = new PVector[N];
PVector[] v = new PVector[N];
PVector[] a = new PVector[N];
float[] angle = new float[N];

//vertical springs rest Length
float[] restY = new float[N];
float k_vert = 0.01;

//horizontal springy stuff and restLength
float[] restH = new float[N];
float k_hori = 0.01;

PVector restL;

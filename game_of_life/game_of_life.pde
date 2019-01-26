float RANDOM_LIMIT = 0.85;

int CELL_RAD = 5;
int CELL_DIA = 2 * CELL_RAD;
int CELL_GRID = 50;

int CANVAS_SIZE = CELL_DIA * CELL_GRID;
int BUTTON_HEIGHT = 50;
int BUTTON_WIDTH = CANVAS_SIZE / 4;

int[][] CELL_ARR = new int[CELL_GRID][CELL_GRID];
int[][] NEW_ARR = new int[CELL_GRID][CELL_GRID];

boolean game_live = false;

void clear_cells()
{
  for (int i = 0; i < CELL_GRID; i++) {
    for (int j = 0; j < CELL_GRID; j++) {
      CELL_ARR[i][j] = 0; 
      NEW_ARR[i][j] = 0;
    }
  }
}

void random_cells()
{
  for (int i = 0; i < CELL_GRID; i++) {
    for (int j = 0; j < CELL_GRID; j++) {
      CELL_ARR[i][j] = (random(1) > RANDOM_LIMIT) ? 1 : 0; 
      NEW_ARR[i][j] = 0;
    }
  }
}

void draw_cells()
{
 // random initialization of cells
  for (int i = 0; i < CELL_GRID; i++) {
    for (int j = 0; j < CELL_GRID; j++) {
      if (CELL_ARR[i][j] >= 1) {
       circle(CELL_RAD + i * CELL_DIA, CELL_RAD + j * CELL_DIA, CELL_DIA); 
      }
    }
  } 
}

void calc_futr_cells()
{
  if (!game_live)
    return;
  
  int nbr = 0;
  for (int i = 0; i < CELL_GRID; i++) {
    for (int j = 0; j < CELL_GRID; j++) {
      nbr = 0;
     
     nbr += (i > 0) && (j > 0) ? CELL_ARR[i - 1][j - 1] : 0;
     nbr += (i > 0) ? CELL_ARR[i - 1][j] : 0;
     nbr += (i > 0) && (j < CELL_GRID - 1) ? CELL_ARR[i - 1][j + 1] : 0;
     
     nbr += (j > 0) ? CELL_ARR[i][j - 1] : 0;
     nbr += (j < CELL_GRID - 1) ? CELL_ARR[i][j + 1] : 0;
     
     nbr += (i < CELL_GRID - 1) && (j > 0) ? CELL_ARR[i + 1][j - 1] : 0;
     nbr += (i < CELL_GRID - 1) ? CELL_ARR[i + 1][j] : 0;
     nbr += (i < CELL_GRID - 1) && (j < CELL_GRID - 1) ? CELL_ARR[i + 1][j + 1] : 0;
     
     // the cell dies in the following two cases
     // 1- LESS THAN TWO NEIGHBOURS
     // 2- MORE THAN THREE NEIGHBOURS
     // new cell is born if a non existant cell has exactly 3 neighbours  
     if (CELL_ARR[i][j] >= 1) {
       if (nbr < 2 || nbr > 3) {
         NEW_ARR[i][j] = 0;
       } else {
        NEW_ARR[i][j] = 1; 
       }
     } else if (CELL_ARR[i][j] < 1 && nbr == 3) {
       NEW_ARR[i][j] = 1; 
     }
    }
  }
  
  // copying the new array into the cell array
    for (int i = 0; i < CELL_GRID; i++) {
        for (int j = 0; j < CELL_GRID; j++) {
            CELL_ARR[i][j] = NEW_ARR[i][j]; 
        }
    }
}

void show_buttons() 
{
    if (!game_live)
        fill(255, 0, 0);
    else
        fill(0, 255, 0);
    
    rect(0, CANVAS_SIZE, BUTTON_WIDTH, BUTTON_HEIGHT); // start stop button
    
    fill(255 * random(1), 255 * random(1), 255 * random(1));
    rect(1*BUTTON_WIDTH, CANVAS_SIZE, BUTTON_WIDTH, BUTTON_HEIGHT); // random button

    fill(0, 0, 255);
    rect(2*BUTTON_WIDTH, CANVAS_SIZE, BUTTON_WIDTH, BUTTON_HEIGHT); // glider button

    fill(0, 0, .5 * 255);
    rect(3*BUTTON_WIDTH, CANVAS_SIZE, BUTTON_WIDTH, BUTTON_HEIGHT); // light weight space ship
    
    fill(255, 255, 255);
    rect(0, CANVAS_SIZE + BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT); // clear screen
    
    fill(255, 255, 0);
    rect(1*BUTTON_WIDTH, CANVAS_SIZE + BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT); // Pulsar
  
    fill(255, 0, 144);
    rect(2*BUTTON_WIDTH, CANVAS_SIZE + BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT); // Pentadecathlon
    
    fill(0, 0, 0);
    rect(3*BUTTON_WIDTH, CANVAS_SIZE + BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT); // Gosper glider gun
  
    fill(255, 255, 255);
}

void settings()
{  
  size(CANVAS_SIZE, CANVAS_SIZE + 100);  
}

void setup()
{
  frameRate(10);
  background(255, 255, 255);
  random_cells();
  draw_cells();
  
  show_buttons();
}

void draw()
{
  background(255, 255, 255);
  calc_futr_cells();
  draw_cells();
  show_buttons();
}

void glider_cells()
{
  clear_cells();
  
  CELL_ARR[1][3] = 1;
  CELL_ARR[2][1] = 1;
  CELL_ARR[2][3] = 1;
  CELL_ARR[3][2] = 1;
  CELL_ARR[3][3] = 1;
}

void light_weight_cells()
{
 clear_cells();
 
 CELL_ARR[1][1] = 1;
 CELL_ARR[1][3] = 1;
 CELL_ARR[2][4] = 1;
 CELL_ARR[3][4] = 1;
 CELL_ARR[4][1] = 1;
 CELL_ARR[4][4] = 1;
 CELL_ARR[5][2] = 1;
 CELL_ARR[5][3] = 1;
 CELL_ARR[5][4] = 1;
}

void pulsar()
{
    clear_cells();
    
    CELL_ARR[3][5] = 1;
    CELL_ARR[3][6] = 1;
    CELL_ARR[3][7] = 1;
    CELL_ARR[3][11] = 1;
    CELL_ARR[3][12] = 1;
    CELL_ARR[3][13] = 1;
    CELL_ARR[5][3] = 1;
    CELL_ARR[5][8] = 1;
    CELL_ARR[5][10] = 1;
    CELL_ARR[5][15] = 1;
    CELL_ARR[6][3] = 1;
    CELL_ARR[6][8] = 1;
    CELL_ARR[6][10] = 1;
    CELL_ARR[6][15] = 1;
    CELL_ARR[7][3] = 1;
    CELL_ARR[7][8] = 1;
    CELL_ARR[7][10] = 1;
    CELL_ARR[7][15] = 1;
    CELL_ARR[8][5] = 1;
    CELL_ARR[8][6] = 1;
    CELL_ARR[8][7] = 1;
    CELL_ARR[8][11] = 1;
    CELL_ARR[8][12] = 1;
    CELL_ARR[8][13] = 1;
    
    CELL_ARR[10][5] = 1;
    CELL_ARR[10][6] = 1;
    CELL_ARR[10][7] = 1;
    CELL_ARR[10][11] = 1;
    CELL_ARR[10][12] = 1;
    CELL_ARR[10][13] = 1;
    CELL_ARR[11][3] = 1;
    CELL_ARR[11][8] = 1;
    CELL_ARR[11][10] = 1;
    CELL_ARR[11][15] = 1;
    CELL_ARR[12][3] = 1;
    CELL_ARR[12][8] = 1;
    CELL_ARR[12][10] = 1;
    CELL_ARR[12][15] = 1;
    CELL_ARR[13][3] = 1;
    CELL_ARR[13][8] = 1;
    CELL_ARR[13][10] = 1;
    CELL_ARR[13][15] = 1;
    CELL_ARR[15][5] = 1;
    CELL_ARR[15][6] = 1;
    CELL_ARR[15][7] = 1;
    CELL_ARR[15][11] = 1;
    CELL_ARR[15][12] = 1;
    CELL_ARR[15][13] = 1;
}

void pentadecathlon()
{
    clear_cells();
    
    CELL_ARR[4][6] = 1;
    CELL_ARR[4][13] = 1;
    CELL_ARR[5][5] = 1;
    CELL_ARR[5][6] = 1;
    CELL_ARR[5][13] = 1;
    CELL_ARR[5][14] = 1;
    CELL_ARR[6][4] = 1;
    CELL_ARR[6][5] = 1;
    CELL_ARR[6][6] = 1;
    CELL_ARR[6][13] = 1;
    CELL_ARR[6][14] = 1;
    CELL_ARR[6][15] = 1;
    CELL_ARR[7][5] = 1;
    CELL_ARR[7][6] = 1;
    CELL_ARR[7][13] = 1;
    CELL_ARR[7][14] = 1;
    CELL_ARR[8][6] = 1;
    CELL_ARR[8][13] = 1;
}

void gosper_glider_cells()
{
    clear_cells();
    
    CELL_ARR[2][6] = 1;
    CELL_ARR[2][7] = 1;
    CELL_ARR[3][6] = 1;
    CELL_ARR[3][7] = 1;

    CELL_ARR[12][6] = 1;
    CELL_ARR[12][7] = 1;
    CELL_ARR[12][8] = 1;
    CELL_ARR[13][5] = 1;
    CELL_ARR[13][9] = 1;
    CELL_ARR[14][4] = 1;
    CELL_ARR[14][10] = 1;
    CELL_ARR[15][4] = 1;
    CELL_ARR[15][10] = 1;
    CELL_ARR[16][7] = 1;
    CELL_ARR[17][5] = 1;
    CELL_ARR[17][9] = 1;
    CELL_ARR[18][6] = 1;
    CELL_ARR[18][7] = 1;
    CELL_ARR[18][8] = 1;
    CELL_ARR[19][7] = 1;
    
    CELL_ARR[22][4] = 1;
    CELL_ARR[22][5] = 1;
    CELL_ARR[22][6] = 1;
    CELL_ARR[23][4] = 1;
    CELL_ARR[23][5] = 1;
    CELL_ARR[23][6] = 1;
    CELL_ARR[24][3] = 1;
    CELL_ARR[24][7] = 1;
    CELL_ARR[26][2] = 1;
    CELL_ARR[26][3] = 1;
    CELL_ARR[26][7] = 1;
    CELL_ARR[26][8] = 1;
    
    CELL_ARR[36][4] = 1;
    CELL_ARR[36][5] = 1;
    CELL_ARR[37][4] = 1;
    CELL_ARR[37][5] = 1;
}

void mouseClicked()
{
    if (!game_live && mouseX > 0 && mouseY > 0 && mouseY < CANVAS_SIZE) {
        int x_cord = floor(mouseX/CELL_DIA);
        int y_cord = floor(mouseY/CELL_DIA);
        
        CELL_ARR[x_cord][y_cord] = CELL_ARR[x_cord][y_cord] >= 1 ? 0 : 1;
     }
    
     //first row of buttons
     if (mouseX > 0 && mouseY > CANVAS_SIZE && mouseY < CANVAS_SIZE + BUTTON_HEIGHT) {
        if (mouseX < BUTTON_WIDTH) {
            if (game_live)
                game_live = false;
            else
                game_live = true;
        } else if (mouseX < 2 * BUTTON_WIDTH) {
            random_cells();
        } else if (mouseX < 3 * BUTTON_WIDTH) {
            glider_cells();
        } else if (mouseX < 4 * BUTTON_WIDTH) {
            light_weight_cells();
        }
    }
    
    // second row of buttons
    if (mouseX > 0 && mouseY > CANVAS_SIZE + BUTTON_HEIGHT && mouseY < CANVAS_SIZE + 2 * BUTTON_HEIGHT) { 
        if (mouseX < BUTTON_WIDTH) {
            clear_cells();
        } else if (mouseX < 2 * BUTTON_WIDTH) {
            pulsar();
        } else if (mouseX < 3 * BUTTON_WIDTH) {
            pentadecathlon();
        } else if (mouseX < 4 * BUTTON_WIDTH) {
            gosper_glider_cells();
        }
    }
}

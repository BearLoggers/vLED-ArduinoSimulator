class LedStripDrawer {
    private int test;
    public LedStripDrawer() {
        
    }
    
    public void draw() {
        
    }
}

class LedStrip {
    public int x;
    public int y;
    
    // Преобразовывает настоящие координаты (в см) в пиксели для отображения на экране
    public int getVirtualX() {
        return x;   
    }
    
    // Преобразовывает настоящие координаты (в см) в пиксели для отображения на экране
    public int getVirtualY() {
        return y;
    }
}

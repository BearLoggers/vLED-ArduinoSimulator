class VirtualScreenDrawer {
    private int _virtualScreenWidthPx;
    private int _virtualScreenHeightPx;
    
    private LedStripDrawer _ledStripDrawer;
    
    /* Технические переменные */
    // Разность между width и _virtualScreenWidthPx, нужно для отрисовки вспомогательных элементов на экране 
    private int _screenAndVirtualScreenWidthDiff;
    // Аналогично, разность между height и _virtualScreenHeightPx
    private int _screenAndVirtualScreenHeightDiff;
        
    
    public VirtualScreenDrawer(int virtualScreenWidthPx, int virtualScreenHeightPx) {
        _virtualScreenWidthPx = virtualScreenWidthPx;
        _virtualScreenHeightPx = virtualScreenHeightPx;
        
        _screenAndVirtualScreenWidthDiff = width - _virtualScreenWidthPx;
        _screenAndVirtualScreenHeightDiff = height - _virtualScreenHeightPx;
        
        /* Генерируем последовательность светодиодных лент */
        // В данный момент поддерживается лишь прямоугольный экран, поэтому всего будет 3 кусочка ленты на экран
        
        //              Сам экран
        //             (вид сзади)
        // ┌──────────────────────────────────┐
        // │  + ─── + ─── + ─── + ─── + ── +  │
        // │ +            Лента             + │
        // │ │    (кресты - "светодиоды")   │ │
        // │ │                              │ │
        // │ +                              + │
        // │ │                              │ │
        // │ │                              │ │
        // │ +                              + │
        // └──────────────────────────────────┘
        // 
        // Лента находится на заданном удалении от краёв
        // Кроме того, нужно обратить внимание на то, что по углам есть разрывы, так как ленту нельзя согнуть на 90°
        // Там нужно будет резать ленту, а затем паять проводами соединения
        // Я думаю можно смело сказать, что это выбрасывает около сантиметра ленты с каждого конца
        
        _ledStripDrawer = new LedStripDrawer();
    }
    
    public void draw() {
       // Сначала рисуем рамки вокруг экрана + помечаем их настоящий размер в см при помощи вспомогательного текста
       drawEdgeAroundScreen(true);
       
       // Рисуем светодиодную ленту
       _ledStripDrawer.draw();
    }
    
    
    /** Вспомогательные функции **/
    private void drawEdgeAroundScreen(boolean shouldPrintRealSizeText) {
        push();
               
        /* Отрисовка рамки виртуального экрана */
        fill(255);
        stroke(200, 100, 100);    // Красноватый
        rectMode(CENTER);
        strokeWeight(1);
        rect(width / 2, height / 2, _virtualScreenWidthPx, _virtualScreenHeightPx);
        
        if (shouldPrintRealSizeText == true) {
            // Пишем размер виртуального экрана в сантиметрах сбоку
            fill(200, 100, 100);
            textSize(14);
            textAlign(CENTER);
            text(configuration.getAreaHeight() + " см", _screenAndVirtualScreenWidthDiff * 0.25, height / 2, _screenAndVirtualScreenWidthDiff * 0.5, 20);   
            
            // Пишем размер виртуального экрана в сантиметрах сверху
            text(configuration.getAreaWidth() + " см", width / 2, _screenAndVirtualScreenHeightDiff * 0.25 + 5, _virtualScreenWidthPx, _screenAndVirtualScreenHeightDiff * 0.5);  
        }
        
        pop();
    }
}

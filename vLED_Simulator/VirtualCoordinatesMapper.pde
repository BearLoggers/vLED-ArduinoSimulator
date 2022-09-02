public class VirtualCoordinatesMapper {
    private int _virtualScreenWidthPx;
    private int _virtualScreenHeightPx;
    private float _cmToPx;
    // Технические переменные
    private int _screenOffsetFromTopPx;    // Смещение виртуального экрана от верхнего края в пикселях
    private int _screenOffsetFromLeftPx;   // Смещение виртуального экрана от левого края в пикселях
    private float _pxToCm;                 // Обратное значение _cmToPx, т.е. сколько сантиметров в одном пикселе
    public VirtualCoordinatesMapper(int virtualScreenWidthPx, int virtualScreenHeightPx, float cmToPx) {
        _virtualScreenWidthPx = virtualScreenWidthPx;
        _virtualScreenHeightPx = virtualScreenHeightPx;
        _cmToPx = cmToPx;
        
        _screenOffsetFromLeftPx = (width - _virtualScreenWidthPx) / 2;
        _screenOffsetFromTopPx = (height - _virtualScreenHeightPx) / 2;
        _pxToCm = 1.0 / _cmToPx;
    }
    
    /** Маппинг из пикселей в см **/
    
    public float getCmFromLeftSide(int offsetX) {
        return getXInsideScreen(offsetX) * _pxToCm;
    }
    
    public float getCmFromTopSide(int offsetY) {
        return getYInsideScreen(offsetY) * _pxToCm;
    } 
    
    public float getCmFromRightSide(int offsetX) {
        return 0;        // TODO: Пока не требовалось
    }
    
    public float getCmFromBottomSide(int offsetY) {
        return 0;        // TODO: Пока не требовалось
    }
    
    /** Маппинг из см в пиксели **/
    
    public int getXfromLeftSide(int offsetCm) {
        return getXInsideScreen((int)(offsetCm * _pxToCm));
    }
    
    public int getYFromTopSide(int offsetCm) {
        return getYInsideScreen((int)(offsetCm * _pxToCm));
    }
    
    public int getXfromRightSide(int offsetCm) {
        return 0;        // TODO: Пока не требовалось
    }
    
    public int getYfromBottomSide(int offsetCm) {
        return 0;       // TODO: Пока не требовалось
    }
    
    /** Вспомогательные функции **/
    private int getXInsideScreen(int offsetX) {
        return offsetX - _screenOffsetFromLeftPx;
    }
    
    private int getYInsideScreen(int offsetY) {
        return offsetY - _screenOffsetFromTopPx;
    }
}

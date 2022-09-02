public class TooltipDrawer {
    public void draw() {
        // Тестовый тултип:
        // Если держат Alt, то показывать расстояние в см от левого верхнего края
        if (keyPressed == true && keyCode == ALT) {
            push();
            
            fill(0);
            textSize(15);
            rectMode(CORNER);
            
            float xCoordCm = virtualCoordsMaper.getCmFromLeftSide(mouseX);
            float yCoordCm = virtualCoordsMaper.getCmFromTopSide(mouseY);
            
            // Если мы можем показать тултип так, чтобы он не исчез за правый экран - то показываем правее от курсора
            // Иначе показываем левее
            int tooltipCoordX = (mouseX + 25 > width - 60 ? mouseX - 85 : mouseX + 25);
            int tooltipCoordY = mouseY + 25;
            
            text(String.format("x:%.2fсм; y:%.2fсм", xCoordCm, yCoordCm), tooltipCoordX, tooltipCoordY);
            
            pop();
        }
    }
}

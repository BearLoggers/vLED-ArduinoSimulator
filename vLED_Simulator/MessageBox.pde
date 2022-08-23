class MessageBoxManager {
    
    // Создаёт новый MessageBox по заданным параметрам
    public void create(String title, String text, int durationSeconds) {
        // Высчитываем сколько кадров нужно будет висеть уведомлению на экране
        int durationFrames = (int)(durationSeconds * frameRate);
        
        // Добавляем новое уведомление в пул
        _messageBoxes.add(new MessageBox(title, text, durationFrames));
    }
    
    // Создаёт новый MessageBox по заданным параметрам, указывает дефолтную длительность сообщения в 3 секунды
    public void create(String title, String text) {
        create(title, text, 3);
    }
    
    private ArrayList<MessageBox> _messageBoxes = new ArrayList<>();
     
    // Функция предназначена для вызова из функции draw, обрабатывает внутреннее состояние MessageBox и показывает уведомления, если требуется
    public void process() {
        // Итерируемся в обратном порядке, чтобы можно было удалять элементы
        for (int i = _messageBoxes.size() - 1; i >= 0; i--) {
            MessageBox mb = _messageBoxes.get(i);
           
            // Если MessageBox возвращает false, то он закончил отображение и его нужно будет удалить
            if (mb.process() == false) {
                _messageBoxes.remove(i);
            }
        }
    }
}

// Внутренний класс для обработки уведомлений
public class MessageBox {
    private int _framesLeft;
    private String _title;
    private String _text;
    
    // Пока что захардкожено
    private int _width = (int)(width * 0.7);
    private int _height = 120;
    
    private int _paddingPx = 5;
    private int _outlinePx = 3;
    
    public MessageBox(String title, String text, int startingFrames) {
        _title = title;
        _text = text;
        _framesLeft = startingFrames;
        
        println(title + ":", text + ";");
    }
    
    private void draw() {
        push();
        
        // Рамка
        rectMode(CENTER);
        stroke(255, 148, 148);        // Розовый
        strokeWeight(_outlinePx);
        fill(230);
        rect(width / 2, height / 2, _width, _height, 20);
        
        // TODO: Сделать адаптивным
        // Заголовок
        final int HEADER_SIZE = 22;
        textSize(HEADER_SIZE);
        
        noStroke();
        fill(0);
        textAlign(CENTER);
        text(_title, width / 2, (height / 2) - _height * 0.3, _width - _paddingPx * 2, HEADER_SIZE * 2);
        
        // Сам текст
        final int TEXT_SIZE = 16;
        textSize(TEXT_SIZE);
        text(_text, width / 2, height / 2 + HEADER_SIZE * 0.5, _width - _paddingPx * 2, _height - HEADER_SIZE * 2.5);
        
        pop();
    }
    
    public boolean process() {
        _framesLeft--;
        if (_framesLeft <= 0) return false;
        
        draw();
        return true;
    }
}

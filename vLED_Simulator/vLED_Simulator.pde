// Кастомный обработчик уведомлений на экране
MessageBoxManager messageBoxManager = new MessageBoxManager();
// Читает конфигурацию из файла и позволяет читать её в любом месте программы
ConfigurationReader configuration;

void setup() {
    // Создаём окно с дефолтным размером
    size(1280, 720);
    // Разрешаем последующее изменение размера окна
    surface.setResizable(true);
    surface.setTitle("vLED - Симулятор");
    
    // Читаем конфигурацию
    configuration = new ConfigurationReader("./Configuration/simulation.conf");
    
    // Изменяем размер окна согласно конфигурации
    int xSize = configuration.getSimScreenWidthPx();
    int ySize = (int)(xSize * (9.0 / 16.0));
    surface.setSize(configuration.getSimScreenWidthPx(), ySize);
    // Запрещаем дальнейшее изменение размера окна (включая ручное изменение размера)
    surface.setResizable(false);
    
    messageBoxManager.create("Hello World!", "Привет, первый коммит!", 100);
}

void draw() {
    background(255);
    
    // Обрабатывает уведомления на экране, которые можно добавить вызывом messageBoxManager.create(...);
    messageBoxManager.process();
}
